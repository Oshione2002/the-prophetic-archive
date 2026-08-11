import 'package:dio/dio.dart';

import '../domain/archive_models.dart';
import 'contracts.dart';

class RemoteAIRepository implements AIRepository {
  RemoteAIRepository({
    required this.baseUrl,
    required this.clientIdProvider,
    Dio? dio,
  }) : _dio = dio ?? Dio();

  final String baseUrl;
  final Future<String> Function() clientIdProvider;
  final Dio _dio;

  @override
  Future<AiAnswer> ask(String question, List<AiSource> sources) async {
    if (question.trim().isEmpty || question.length > 1000) {
      throw ArgumentError(
        'Question must contain between 1 and 1,000 characters.',
      );
    }
    final selected = sources.take(8).toList();
    if (selected.fold<int>(0, (sum, source) => sum + source.text.length) >
        12000) {
      throw ArgumentError(
        'Retrieved archive context exceeds 12,000 characters.',
      );
    }
    final response = await _dio.post<Map<String, Object?>>(
      '$baseUrl/v1/ask',
      data: <String, Object?>{
        'question': question,
        'sources': selected.map((source) => source.toJson()).toList(),
      },
      options: Options(
        headers: <String, Object?>{'x-client-id': await clientIdProvider()},
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
    final data = response.data;
    if (data == null ||
        data['answer'] is! String ||
        data['citations'] is! List<Object?>) {
      throw const FormatException(
        'The AI service returned an invalid response.',
      );
    }
    final citations = validateAiCitationIds(
      data['citations'],
      selected.map((source) => source.sourceId).toSet(),
    );
    return AiAnswer(answer: data['answer']! as String, citationIds: citations);
  }
}

List<String> validateAiCitationIds(Object? value, Set<String> allowed) {
  if (value is! List<Object?>) {
    throw const FormatException('AI citations must be a list.');
  }
  final result = <String>[];
  for (final citation in value) {
    if (citation is! Map<String, Object?> || citation['sourceId'] is! String) {
      throw const FormatException('AI response contains a malformed citation.');
    }
    final sourceId = citation['sourceId']! as String;
    if (!allowed.contains(sourceId)) {
      throw FormatException(
        'AI response cited an unrequested source: $sourceId',
      );
    }
    if (!result.contains(sourceId)) result.add(sourceId);
  }
  return result;
}

class UnavailableAIRepository implements AIRepository {
  const UnavailableAIRepository();

  @override
  Future<AiAnswer> ask(String question, List<AiSource> sources) async {
    throw StateError(
      'Ask the Library is unavailable until a secure AI service is configured.',
    );
  }
}
