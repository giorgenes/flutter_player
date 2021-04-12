import 'package:audioplayers/audioplayers.dart';
import 'song.dart';
import 'package:flutter/material.dart';

class MusicPlayer {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  State<StatefulWidget> parentState;

  MusicPlayer(State<StatefulWidget> state) {
    parentState = state;

    audioPlayer.onPlayerCompletion.listen((event) {
      print('completed');

      parentState.setState(() {
        isPlaying = false;
      });
    });
  }

  play(Song song) async {
    int result = await audioPlayer.play(song.sampleUrl);
    if (result == 1) {
      // success
    }
  }
}
