import { describe, expect, it } from 'vitest';
import { validateAskRequest, validateCitations } from '../src/index';

const source = {
  sourceId: 'translation-alert-001:point-023',
  collection: 'Translation Alerts',
  document: '001 — Test',
  blockLabel: 'Point 23',
  text: 'Archive passage',
};

describe('Ask the Library validation', () => {
  it('accepts bounded archive-only requests', () => {
    expect(validateAskRequest({ question: 'What does it say?', sources: [source] }).sources).toHaveLength(1);
  });

  it('rejects oversized context', () => {
    expect(() => validateAskRequest({ question: 'Question', sources: [{ ...source, text: 'x'.repeat(12_001) }] })).toThrow();
  });

  it('rejects fabricated citations', () => {
    expect(() => validateCitations(
      { answer: 'Answer', citations: [{ sourceId: source.sourceId }, { sourceId: 'invented:block' }] },
      [source],
    )).toThrow(/not supplied/);
  });

  it('rejects duplicate source ids and more than eight sources', () => {
    expect(() => validateAskRequest({ question: 'Question', sources: [source, source] })).toThrow(/unique/);
    expect(() => validateAskRequest({
      question: 'Question',
      sources: Array.from({ length: 9 }, (_, index) => ({ ...source, sourceId: `doc:block-${index}` })),
    })).toThrow(/eight/);
  });

  it('rejects empty and oversized questions', () => {
    expect(() => validateAskRequest({ question: '', sources: [] })).toThrow();
    expect(() => validateAskRequest({ question: 'x'.repeat(1_001), sources: [] })).toThrow();
  });
});
