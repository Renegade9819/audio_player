// ignore_for_file: file_names

import 'package:audio_player/controllers/AudioController.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioSlider extends StatefulWidget {
  const AudioSlider({
    Key? key,
  }) : super(key: key);

  @override
  _AudioSliderState createState() => _AudioSliderState();
}

class _AudioSliderState extends State<AudioSlider> {
  AudioController audioController = AudioController();
  Duration? duration;
  Duration? position;

  @override
  Widget build(BuildContext context) {
    audioController.audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      if (s == PlayerState.STOPPED) {
        setState(() {
          position = const Duration(seconds: 0);
        });
      }
    });

    audioController.audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
      });
    });
    audioController.audioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });

    return Slider(
      value: position == null ? 0.0 : position!.inSeconds.toDouble(),
      min: 0.0,
      max: duration == null ? 0.0 : duration!.inSeconds.toDouble(),
      onChanged: (v) =>
          audioController.audioPlayer.seek(Duration(seconds: v.toInt())),
      activeColor: Colors.lightGreenAccent,
      inactiveColor: Colors.white,
    );
  }
}
