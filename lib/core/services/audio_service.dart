import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playCorrect() => _player.play(AssetSource('images/correct.mp3'));

  Future<void> playWrong() => _player.play(AssetSource('images/wrong.mp3'));
}
