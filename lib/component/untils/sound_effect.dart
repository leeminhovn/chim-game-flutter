import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:just_audio/just_audio.dart';

class AudioPlay {
  late AudioPlayer _player;
  final String assetsFile;
  AudioPlay({required this.assetsFile}) {
    _player = AudioPlayer();
    _player.setAsset('assets/sound_effect/$assetsFile');
  }
  handlePlayAudio() async {
    if (!kIsWeb) {
      await _player.seek(Duration.zero);
    } else {
      await _player.setAsset('assets/sound_effect/$assetsFile');
    }
    // _player.seekToNext();
    _player.play();
  }

  dispose() {
    _player.dispose();
  }
}
