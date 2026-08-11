export interface ArchiveSource {
  sourceId: string;
  collection: string;
  document: string;
  blockLabel?: string | null;
  text: string;
}

export interface AskRequest {
  question: string;
  sources: ArchiveSource[];
}

export interface AskResult {
  answer: string;
  citations: Array<{ sourceId: string }>;
}

interface Env {
  GEMINI_API_KEY: string;
  GEMINI_MODEL: string;
  AI_RATE_LIMITER: RateLimit;
}

export interface AIProvider {
  answer(request: AskRequest, signal: AbortSignal): Promise<AskResult>;
}

const systemInstruction = `You are the research assistant for The Prophetic Archive.
Answer the user's question only from the archive passages supplied in the current request.
Do not introduce doctrine, history, factual claims or interpretations not supported by those passages.
If the passages are insufficient, clearly say the retrieved archive material does not establish an answer.
Cite supplied source IDs for substantive claims. Never invent a source ID.`;

export class GeminiProvider implements AIProvider {
  constructor(private readonly env: Pick<Env, 'GEMINI_API_KEY' | 'GEMINI_MODEL'>) {}

  async answer(request: AskRequest, signal: AbortSignal): Promise<AskResult> {
    const response = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/${encodeURIComponent(this.env.GEMINI_MODEL)}:generateContent`,
      {
        method: 'POST',
        headers: {
          'content-type': 'application/json',
          'x-goog-api-key': this.env.GEMINI_API_KEY,
        },
        signal,
        body: JSON.stringify({
          systemInstruction: { parts: [{ text: systemInstruction }] },
          contents: [{
            role: 'user',
            parts: [{ text: JSON.stringify(request) }],
          }],
          generationConfig: {
            responseMimeType: 'application/json',
            responseJsonSchema: {
              type: 'object',
              required: ['answer', 'citations'],
              additionalProperties: false,
              properties: {
                answer: { type: 'string' },
                citations: {
                  type: 'array',
                  items: {
                    type: 'object',
                    required: ['sourceId'],
                    additionalProperties: false,
                    properties: { sourceId: { type: 'string' } },
                  },
                },
              },
            },
          },
        }),
      },
    );
    if (!response.ok) throw new Error(`AI provider failed with status ${response.status}`);
    const payload = await response.json() as {
      candidates?: Array<{ content?: { parts?: Array<{ text?: string }> } }>;
    };
    const text = payload.candidates?.[0]?.content?.parts?.[0]?.text;
    if (!text) throw new Error('AI provider returned no structured answer');
    return JSON.parse(text) as AskResult;
  }
}

export function validateAskRequest(value: unknown): AskRequest {
  if (!value || typeof value !== 'object') throw new Error('Request body must be an object');
  const candidate = value as Partial<AskRequest>;
  if (typeof candidate.question !== 'string' || candidate.question.trim().length === 0 || candidate.question.length > 1000) {
    throw new Error('Question must contain between 1 and 1,000 characters');
  }
  if (!Array.isArray(candidate.sources) || candidate.sources.length > 8) {
    throw new Error('At most eight archive sources may be supplied');
  }
  let total = 0;
  const ids = new Set<string>();
  for (const source of candidate.sources) {
    if (!source || typeof source.sourceId !== 'string' || !source.sourceId.includes(':') || ids.has(source.sourceId)) {
      throw new Error('Every source requires a unique stable sourceId');
    }
    if (typeof source.collection !== 'string' || typeof source.document !== 'string' || typeof source.text !== 'string') {
      throw new Error('Invalid archive source');
    }
    total += source.text.length;
    ids.add(source.sourceId);
  }
  if (total > 12_000) throw new Error('Archive context exceeds 12,000 characters');
  return candidate as AskRequest;
}

export function validateCitations(result: AskResult, sources: ArchiveSource[]): AskResult {
  if (!result || typeof result.answer !== 'string' || !Array.isArray(result.citations)) {
    throw new Error('AI response is invalid');
  }
  const allowed = new Set(sources.map((source) => source.sourceId));
  for (const citation of result.citations) {
    if (!citation || typeof citation.sourceId !== 'string' || !allowed.has(citation.sourceId)) {
      throw new Error('AI response cited a source that was not supplied');
    }
  }
  return {
    answer: result.answer,
    citations: result.citations
      .filter((citation, index, all) => all.findIndex((item) => item.sourceId === citation.sourceId) === index),
  };
}

export async function handleAsk(request: Request, env: Env, provider: AIProvider): Promise<Response> {
  const contentLength = Number(request.headers.get('content-length') ?? '0');
  if (contentLength > 65_536) return jsonResponse({ error: 'Request too large' }, 413);
  let payload: AskRequest;
  try {
    payload = validateAskRequest(await request.json());
  } catch (error) {
    return jsonResponse({ error: error instanceof Error ? error.message : 'Invalid request' }, 400);
  }
  const clientId = request.headers.get('x-client-id');
  if (!clientId || !/^[A-Za-z0-9-]{16,128}$/.test(clientId)) {
    return jsonResponse({ error: 'A valid anonymous client id is required' }, 400);
  }
  const limit = await env.AI_RATE_LIMITER.limit({ key: clientId });
  if (!limit.success) return jsonResponse({ error: 'Rate limit exceeded' }, 429);

  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), 15_000);
  try {
    const result = validateCitations(await provider.answer(payload, controller.signal), payload.sources);
    return jsonResponse(result, 200);
  } catch {
    return jsonResponse({ error: 'Ask the Library is temporarily unavailable' }, 503);
  } finally {
    clearTimeout(timeout);
  }
}

function jsonResponse(body: unknown, status: number): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: {
      'content-type': 'application/json; charset=utf-8',
      'cache-control': 'no-store',
      'x-content-type-options': 'nosniff',
      'referrer-policy': 'no-referrer',
    },
  });
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);
    if (url.pathname !== '/v1/ask') return jsonResponse({ error: 'Not found' }, 404);
    if (request.method !== 'POST') return jsonResponse({ error: 'Method not allowed' }, 405);
    return handleAsk(request, env, new GeminiProvider(env));
  },
} satisfies ExportedHandler<Env>;
