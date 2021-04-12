import 'dart:core';

import 'package:flutter/material.dart';
import 'song_widget.dart';
import 'song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'song_finder.dart';
import 'player_control_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// MediaQuery.of()

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController;

  // player related
  List<Song> songs = [];
  AudioPlayer player;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();

    player = AudioPlayer();

    // update the playing status when the song finishes
    player.onPlayerCompletion.listen((event) {
      print('completed');

      setState(() {
        isPlaying = false;
      });
    });

    performSearch('metallica');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void performSearch(String query) async {
    var foundSongs = await SongFinder.findBy(query);

    setState(() {
      this.songs = foundSongs;
    });
  }

  play(Song song, BuildContext context) async {
    int result = await player.play(song.sampleUrl);

    // success?
    if (result == 1) {
      setState(() {
        isPlaying = true;
      });

      OverlayState overlayState = Overlay.of(context);

      overlayState.insert(
        OverlayEntry(
          builder: (context) => Positioned(
            bottom: 0.0,
            left: 0,
            right: 0,
            child: PlayerControlWidget(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listViewItems;

    listViewItems = [
      for (Song song in songs)
        SongWidget(
          song: song,
          onPlay: (Song song) {
            play(song, context);
          },
        )
    ];

    listViewItems.insert(
      0,
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextField(
          controller: _searchController,
          onSubmitted: (String value) {
            performSearch(value);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Search artist',
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: listViewItems
          // TODO: Add padding at the end to account for the play nav at the bottom
          ,
        ),
      ),
    );
  }
}
