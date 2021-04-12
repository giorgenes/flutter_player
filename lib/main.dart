import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sample_player_app/screens/playlist_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: PlaylistScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
