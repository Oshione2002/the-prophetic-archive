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
  Completer<void>? _resumeCompleter;

  @override
  Future<void> speak(List<DocumentBlock> blocks, {double rate = 0.5}) async {
    final generation = ++_generation;
    _paused = false;
    await _engine.stop();
    await _engine.setSpeechRate((rate / 2).clamp(0.2, 0.9));
    await _engine.awaitSpeakCompletion(true);
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
      final result = await _engine.speak(block.text);
      if (generation != _generation) return;
      if (_paused) continue;
      if (result != 1) return;
      index++;
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
