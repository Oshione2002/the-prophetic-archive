import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/domain/archive_models.dart';
import '../../core/providers.dart';
import '../../core/repositories/archive_audio_player.dart';

class DocumentAudioControls extends ConsumerStatefulWidget {
  const DocumentAudioControls({required this.document, super.key});
  final ArchiveDocument document;

  @override
  ConsumerState<DocumentAudioControls> createState() =>
      _DocumentAudioControlsState();
}

class _DocumentAudioControlsState extends ConsumerState<DocumentAudioControls> {
  StreamSubscription<ArchiveAudioState>? _subscription;
  ArchiveAudioState _state = const ArchiveAudioState();
  var _working = false;
  int _lastSavedSecond = -1;

  List<DocumentAsset> get _tracks => widget.document.audioAssets;
  int get _trackIndex =>
      _tracks.indexWhere((track) => track.id == _state.asset?.id);

  @override
  void initState() {
    super.initState();
    final player = ref.read(archiveAudioPlayerProvider);
    _state = player.state;
    _subscription = player.states.listen((state) {
      if (!mounted) return;
      setState(() => _state = state);
      final seconds = state.position.inSeconds;
      if (state.asset != null &&
          seconds != _lastSavedSecond &&
          seconds % 5 == 0) {
        _lastSavedSecond = seconds;
        unawaited(
          ref
              .read(archiveRepositoryProvider)
              .setValue('audio_position:${state.asset!.id}', '$seconds'),
        );
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _select(DocumentAsset track, {bool autoplay = true}) async {
    if (track.localPath == null) return;
    final stored = await ref
        .read(archiveRepositoryProvider)
        .getValue('audio_position:${track.id}');
    await ref
        .read(archiveAudioPlayerProvider)
        .load(
          track,
          initialPosition: Duration(seconds: int.tryParse(stored ?? '') ?? 0),
        );
    if (autoplay) await ref.read(archiveAudioPlayerProvider).play();
  }

  Future<void> _download(DocumentAsset track) async {
    setState(() => _working = true);
    try {
      await ref
          .read(archiveRepositoryProvider)
          .downloadAsset(widget.document.id, track);
      ref
        ..invalidate(documentProvider(widget.document.id))
        ..invalidate(storageSummaryProvider);
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _move(int delta) async {
    if (_tracks.isEmpty) return;
    final index = (_trackIndex < 0 ? 0 : _trackIndex + delta).clamp(
      0,
      _tracks.length - 1,
    );
    await _select(_tracks[index]);
  }

  @override
  Widget build(BuildContext context) {
    if (_tracks.isEmpty) return const SizedBox.shrink();
    final active = _state.asset == null
        ? _tracks.first
        : _tracks.firstWhere(
            (track) => track.id == _state.asset!.id,
            orElse: () => _tracks.first,
          );
    final maxMs = _state.duration.inMilliseconds > 0
        ? _state.duration.inMilliseconds.toDouble()
        : 1.0;
    final positionMs = _state.position.inMilliseconds
        .clamp(0, maxMs.toInt())
        .toDouble();
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              active.title ?? 'Audio',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (active.localPath == null) ...<Widget>[
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _working ? null : () => _download(active),
                icon: _working
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.download),
                label: const Text('Download audio'),
              ),
            ] else ...<Widget>[
              Slider(
                value: positionMs,
                max: maxMs,
                onChanged: (value) => ref
                    .read(archiveAudioPlayerProvider)
                    .seek(Duration(milliseconds: value.round())),
              ),
              Row(
                children: <Widget>[
                  Text(_time(_state.position)),
                  const Spacer(),
                  Text(_time(_state.duration)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    tooltip: 'Previous track',
                    onPressed: _trackIndex <= 0 ? null : () => _move(-1),
                    icon: const Icon(Icons.skip_previous),
                  ),
                  IconButton.filled(
                    tooltip: _state.playing ? 'Pause' : 'Play',
                    onPressed: () async {
                      final player = ref.read(archiveAudioPlayerProvider);
                      if (_state.asset?.id != active.id) {
                        await _select(active, autoplay: false);
                      }
                      _state.playing
                          ? await player.pause()
                          : await player.play();
                    },
                    icon: Icon(_state.playing ? Icons.pause : Icons.play_arrow),
                  ),
                  IconButton(
                    tooltip: 'Next track',
                    onPressed: _trackIndex >= _tracks.length - 1
                        ? null
                        : () => _move(1),
                    icon: const Icon(Icons.skip_next),
                  ),
                  const SizedBox(width: 12),
                  DropdownButton<double>(
                    value: _state.speed,
                    items: const <DropdownMenuItem<double>>[
                      DropdownMenuItem(value: 0.5, child: Text('0.5x')),
                      DropdownMenuItem(value: 1, child: Text('1.0x')),
                      DropdownMenuItem(value: 1.5, child: Text('1.5x')),
                      DropdownMenuItem(value: 2, child: Text('2.0x')),
                    ],
                    onChanged: (speed) {
                      if (speed != null) {
                        ref.read(archiveAudioPlayerProvider).setSpeed(speed);
                      }
                    },
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

String _time(Duration duration) {
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
