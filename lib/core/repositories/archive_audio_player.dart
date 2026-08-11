import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

import '../domain/archive_models.dart';

class ArchiveAudioState {
  const ArchiveAudioState({
    this.asset,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.speed = 1,
    this.playing = false,
    this.loading = false,
  });

  final DocumentAsset? asset;
  final Duration position;
  final Duration duration;
  final double speed;
  final bool playing;
  final bool loading;

  ArchiveAudioState copyWith({
    DocumentAsset? asset,
    Duration? position,
    Duration? duration,
    double? speed,
    bool? playing,
    bool? loading,
  }) => ArchiveAudioState(
    asset: asset ?? this.asset,
    position: position ?? this.position,
    duration: duration ?? this.duration,
    speed: speed ?? this.speed,
    playing: playing ?? this.playing,
    loading: loading ?? this.loading,
  );
}

class ArchiveAudioPlayer {
  ArchiveAudioPlayer({AudioPlayer? player})
    : _player = player ?? AudioPlayer() {
    _subscriptions.addAll(<StreamSubscription<Object?>>[
      _player.onPositionChanged.listen(
        (position) => _emit(_state.copyWith(position: position)),
      ),
      _player.onDurationChanged.listen(
        (duration) => _emit(_state.copyWith(duration: duration)),
      ),
      _player.onPlayerStateChanged.listen(
        (state) => _emit(
          _state.copyWith(
            playing: state == PlayerState.playing,
            loading: false,
          ),
        ),
      ),
      _player.onPlayerComplete.listen(
        (_) =>
            _emit(_state.copyWith(position: _state.duration, playing: false)),
      ),
    ]);
  }

  final AudioPlayer _player;
  final _controller = StreamController<ArchiveAudioState>.broadcast();
  final _subscriptions = <StreamSubscription<Object?>>[];
  ArchiveAudioState _state = const ArchiveAudioState();

  ArchiveAudioState get state => _state;
  Stream<ArchiveAudioState> get states => _controller.stream;

  Future<void> load(
    DocumentAsset asset, {
    Duration initialPosition = Duration.zero,
  }) async {
    final path = asset.localPath;
    if (path == null) {
      throw StateError('Download this audio before playing it.');
    }
    _emit(
      ArchiveAudioState(
        asset: asset,
        position: initialPosition,
        duration: Duration(seconds: asset.durationSeconds ?? 0),
        speed: _state.speed,
        loading: true,
      ),
    );
    await _player.setReleaseMode(ReleaseMode.stop);
    await _player.setSource(DeviceFileSource(path));
    await _player.setPlaybackRate(_state.speed);
    if (initialPosition > Duration.zero) await _player.seek(initialPosition);
  }

  Future<void> play() async {
    if (_state.asset == null) return;
    await _player.resume();
  }

  Future<void> pause() => _player.pause();
  Future<void> seek(Duration value) => _player.seek(value);

  Future<void> setSpeed(double value) async {
    await _player.setPlaybackRate(value);
    _emit(_state.copyWith(speed: value));
  }

  Future<void> stop() async {
    await _player.stop();
    _emit(_state.copyWith(position: Duration.zero, playing: false));
  }

  void _emit(ArchiveAudioState value) {
    _state = value;
    if (!_controller.isClosed) _controller.add(value);
  }

  Future<void> dispose() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    await _player.dispose();
    await _controller.close();
  }
}
