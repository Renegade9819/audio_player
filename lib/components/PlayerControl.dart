// ignore_for_file: file_names

import 'package:audio_player/controllers/AudioController.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayerControl extends StatefulWidget {
  const PlayerControl({Key? key}) : super(key: key);

  @override
  _PlayerControlState createState() => _PlayerControlState();
}

class _PlayerControlState extends State<PlayerControl> {
  AudioController audioController = AudioController();
  PlayerState playerState = PlayerState.STOPPED;

  @override
  void initState() {
    audioController.audioPlayer.onPlayerStateChanged.listen((s) {
      playerState = s;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              if (playerState == PlayerState.PLAYING) {
                setState(() {
                  pauseMusic();
                  playerState == PlayerState.PAUSED;
                });
              } else if (playerState == PlayerState.PAUSED ||
                  playerState == PlayerState.STOPPED) {
                setState(() {
                  resumeMusic();
                  playerState = PlayerState.PLAYING;
                });
              }
            });
          },
          icon: playerState == PlayerState.PLAYING
              ? const Icon(
                  Icons.pause,
                  size: 50.0,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.play_arrow_rounded,
                  size: 50.0,
                  color: Colors.white,
                ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              stopMusic();
              playerState = PlayerState.STOPPED;
            });
          },
          icon: const Icon(
            Icons.stop,
            size: 50.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Future<int> resumeMusic() async {
    int result = await audioController.resumeMusic();
    return result;
  }

  Future<int> pauseMusic() async {
    int result = await audioController.pauseMusic();
    return result;
  }

  Future<int> stopMusic() async {
    int result = await audioController.stopMusic();
    return result;
  }
}
