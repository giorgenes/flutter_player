import 'package:flutter/material.dart';

class PlayerControlWidget extends StatelessWidget {
  final bool isPlaying;

  PlayerControlWidget({this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fast_rewind,
                color: Colors.green,
                size: 60.0,
              ),
              Icon(Icons.play_arrow, color: Colors.green, size: 60.0),
              Icon(Icons.fast_forward, color: Colors.green, size: 60.0),
            ],
          )
        ],
      ),
    );
  }
}
