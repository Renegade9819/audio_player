import 'dart:io';
import 'dart:typed_data';

import 'package:audio_player/components/AudioSlider.dart';
import 'package:audio_player/components/PlayerControl.dart';
import 'package:audio_player/controllers/AudioController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  Uint8List? albumArt;
  Image? albumImage;
  String? trackName;
  String? artistName;
  PlatformFile? file;
  late String filePath;
  bool isPicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
              child: ElevatedButton(
                child: const Text(
                  'Pick Song',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.audio,
                  );
                  if (result != null) {
                    file = result.files.single;
                    var metadata =
                        await MetadataRetriever.fromFile(File(file!.path!));

                    setState(() {
                      trackName = metadata.trackName;
                      artistName = metadata.trackArtistNames![0];
                      albumArt = metadata.albumArt;
                      albumImage = Image.memory(albumArt!);
                      filePath = file!.path!;
                      isPicked = true;
                      AudioController().setFilePath(filePath);
                      AudioController().playMusic();
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("No file Fetched"),
                        action:
                            SnackBarAction(label: 'Close', onPressed: () {}),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
              // child: const Text(
              //   'Audio Player',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 22.0,
              //   ),
              // ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              height: 300,
              width: 300,
              //color: Colors.white54,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  style: BorderStyle.solid,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: isPicked
                      ? albumImage!.image
                      : const NetworkImage("https://tinyurl.com/3jp9mhw7"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  isPicked ? "Now Playing: ${trackName!}" : "Song Name",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  isPicked ? artistName! : "Artist Name",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            const AudioSlider(),
            const SizedBox(
              height: 10.0,
            ),
            const PlayerControl(),
          ],
        ),
      ),
    );
  }
}
