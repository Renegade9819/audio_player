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
  double duration = 0;
  double value = 0.0;
  double maxValue = 0.0;

  @override
  Widget build(BuildContext context) {
    audioController.audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      if (s == PlayerState.STOPPED) {
        setState(() {
          value = 0.0;
        });
      }
    });

    audioController.audioPlayer.onDurationChanged.listen((Duration d) {
      duration = d.inSeconds.toDouble() / 100;
    });
    audioController.audioPlayer.onAudioPositionChanged.listen((Duration p) {
      value = p.inSeconds.toDouble() / 100;
      setState(() {});
    });

    return Slider(
      value: value,
      min: 0.0,
      max: duration,
      onChanged: (v) {},
      activeColor: Colors.lightGreenAccent,
      inactiveColor: Colors.white,
    );
  }
}
