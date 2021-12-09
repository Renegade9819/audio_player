// ignore_for_file: file_names

import 'package:audioplayers/audioplayers.dart';

class AudioController {
  String? filePath;

  AudioPlayer audioPlayer = AudioPlayer();

  static final AudioController audioController = AudioController.initialize();

  factory AudioController() {
    return audioController;
  }

  AudioController.initialize();

  void setFilePath(String filePath) {
    this.filePath = filePath;
  }

  Future<int> playMusic() async {
    int result = await audioPlayer.play(filePath!);
    return result;
  }

  Future<int> resumeMusic() async {
    int result = await audioPlayer.resume();
    return result;
  }

  Future<int> pauseMusic() async {
    int result = await audioPlayer.pause();
    return result;
  }

  Future<int> stopMusic() async {
    int result = await audioPlayer.stop();
    //audioPlayer.release();
    return result;
  }
}
