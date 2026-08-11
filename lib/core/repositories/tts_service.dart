import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';

import '../domain/archive_models.dart';
import 'contracts.dart';

class DeviceTextToSpeechService implements TextToSpeechService {
  DeviceTextToSpeechService({FlutterTts? engine})
    : _engine = engine ?? FlutterTts();

  final FlutterTts _engine;
  var _generation = 0;
  var _paused = false;
  var _voiceConfigured = false;
  Completer<void>? _resumeCompleter;

  @override
  Future<void> speak(
    List<DocumentBlock> blocks, {
    double rate = 0.5,
    void Function(DocumentBlock block)? onBlockChanged,
    void Function(DocumentBlock block, int start, int end)? onProgress,
  }) async {
    final generation = ++_generation;
    _paused = false;
    await _engine.stop();
    await _configureVoice();
    await _engine.setSpeechRate(((rate / 2) * 0.9).clamp(0.18, 0.9));
    await _engine.awaitSpeakCompletion(true);
    DocumentBlock? activeBlock;
    _engine.setProgressHandler((text, start, end, word) {
      final block = activeBlock;
      if (generation != _generation || block == null) return;
      onProgress?.call(
        block,
        start.clamp(0, block.text.length),
        end.clamp(0, block.text.length),
      );
    });
    var index = 0;
    while (index < blocks.length && generation == _generation) {
      if (_paused) {
        _resumeCompleter ??= Completer<void>();
        await _resumeCompleter!.future;
        if (generation != _generation) return;
      }
      final block = blocks[index];
      if (block.text.trim().isEmpty) {
        index++;
        continue;
      }
      activeBlock = block;
      onBlockChanged?.call(block);
      final result = await _engine.speak(block.text);
      if (generation != _generation) return;
      if (_paused) continue;
      if (result != 1) return;
      index++;
    }
  }

  Future<void> _configureVoice() async {
    if (_voiceConfigured) return;
    _voiceConfigured = true;
    try {
      final rawVoices = await _engine.getVoices;
      if (rawVoices is! List) return;
      final voices = rawVoices.whereType<Map>().toList();
      Map? selected;
      for (final voice in voices) {
        final name = voice['name']?.toString().toLowerCase() ?? '';
        if (name.contains('microsoft andrew') || name == 'andrew') {
          selected = voice;
          break;
        }
      }
      selected ??= voices.cast<Map?>().firstWhere((voice) {
        final locale = voice?['locale']?.toString().toLowerCase() ?? '';
        final name = voice?['name']?.toString().toLowerCase() ?? '';
        final gender = voice?['gender']?.toString().toLowerCase() ?? '';
        return locale.startsWith('en') &&
            (gender == 'male' ||
                name.contains('male') ||
                name.contains('andrew'));
      }, orElse: () => null);
      if (selected != null) {
        await _engine.setVoice(<String, String>{
          'name': selected['name'].toString(),
          'locale': selected['locale']?.toString() ?? 'en-US',
        });
      }
    } catch (_) {
      // Voice discovery differs by platform; the system voice remains usable.
    }
  }

  @override
  Future<void> pause() async {
    if (_paused) return;
    _paused = true;
    _resumeCompleter = Completer<void>();
    await _engine.pause();
  }

  @override
  Future<void> resume() async {
    if (!_paused) return;
    _paused = false;
    _resumeCompleter?.complete();
    _resumeCompleter = null;
  }

  @override
  Future<void> stop() async {
    _generation++;
    _paused = false;
    _resumeCompleter?.complete();
    _resumeCompleter = null;
    await _engine.stop();
  }
}
