import 'package:flutter/material.dart';

class PlayerControlWidget extends StatelessWidget {
  final bool isPlaying;
  final Function onRewind;
  final Function onForward;
  final Function onPlay;
  final Function onPause;

  PlayerControlWidget(
      {this.isPlaying,
      this.onRewind,
      this.onForward,
      this.onPlay,
      this.onPause});

  @override
  Widget build(BuildContext context) {
    Widget playPauseButton;

    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onRewind,
                child: Icon(
                  Icons.fast_rewind,
                  color: Colors.green,
                  size: 60.0,
                ),
              ),
              GestureDetector(
                onTap: isPlaying ? onPause : onPlay,
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.green,
                  size: 60.0,
                ),
              ),
              GestureDetector(
                onTap: onForward,
                child:
                    Icon(Icons.fast_forward, color: Colors.green, size: 60.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}
