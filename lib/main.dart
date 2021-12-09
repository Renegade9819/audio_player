import 'package:audio_player/screens/music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MaterialApp(
    title: 'Audio Player',
    home: MusicPlayer(),
    debugShowCheckedModeBanner: false,
  ));
}
