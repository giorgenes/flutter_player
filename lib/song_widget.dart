import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'song.dart';

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
        child: Container(
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                song.coverUrl,
                width: 100.0,
                height: 100.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          song.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          song.artist,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Text(song.album),
                    ],
                  ),
                ),
              ),
              SpinKitWave(
                color: Colors.black,
                size: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
