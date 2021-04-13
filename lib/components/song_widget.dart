import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../song.dart';

const TextStyle songNameStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

const TextStyle artistStyle = TextStyle(fontSize: 16.0);

const textPadding = EdgeInsets.only(bottom: 5.0);

// The song card widget (cover art and song name, artist, etc)
class SongWidget extends StatelessWidget {
  final Song song;
  final Function onPlay;
  final bool isPlaying;

  const SongWidget({this.song, this.onPlay, this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 15.0, right: 15.0),
      child: GestureDetector(
        onTap: () {
          onPlay(song);
        },
        child: Card(
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                song.coverUrl,
                width: 100.0,
                height: 100.0,
              ),
              buildSongDetails(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: isPlaying ? buildPlayingStatus() : buildPlayArrow(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds a column with the song name, artist and album
  Widget buildSongDetails() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: textPadding,
              child: Text(song.name, style: songNameStyle),
            ),
            Padding(
              padding: textPadding,
              child: Text(song.artist, style: artistStyle),
            ),
            Text(song.album),
          ],
        ),
      ),
    );
  }

  // The "playing" status indicator animation
  Widget buildPlayingStatus() {
    return SpinKitWave(
      color: Colors.black,
      size: 25.0,
    );
  }

  Icon buildPlayArrow() => Icon(Icons.play_arrow, size: 45.0);
}
