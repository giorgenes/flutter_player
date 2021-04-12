import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

class Song {
  final String name;
  final String artist;
  final String album;
  final String coverUrl;
  final String sampleUrl;

  Song({this.name, this.artist, this.album, this.coverUrl, this.sampleUrl});

  play(AudioPlayer audioPlayer) async {
    int result = await audioPlayer.play(sampleUrl);
    if (result == 1) {
      // success
    }
  }
}
