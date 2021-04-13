import 'package:flutter/material.dart';

// Builds the bottom player control with the play/skip/pause buttons
class PlayerControlWidget extends StatelessWidget {
  final bool isPlaying;
  final Function onRewind;
  final Function onForward;
  final Function onPlay;
  final Function onPause;

  static Color buttonColor = Color(0xFFE91E63);

  PlayerControlWidget(
      {this.isPlaying,
      this.onRewind,
      this.onForward,
      this.onPlay,
      this.onPause});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildRewindButton(),
          buildPlayButton(),
          buildForwardButton(),
        ],
      ),
    );
  }

  Widget buildRewindButton() => GestureDetector(
        onTap: onRewind,
        child: Icon(
          Icons.fast_rewind,
          color: Colors.white,
          size: 60.0,
        ),
      );

  Widget buildForwardButton() {
    return GestureDetector(
      onTap: onForward,
      child: Icon(Icons.fast_forward, color: Colors.white, size: 60.0),
    );
  }

  Widget buildPlayButton() {
    return GestureDetector(
      onTap: isPlaying ? onPause : onPlay,
      child: Icon(
        isPlaying ? Icons.pause : Icons.play_circle_fill,
        color: buttonColor,
        size: 80.0,
      ),
    );
  }
}
