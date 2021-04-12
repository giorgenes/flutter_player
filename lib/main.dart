import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'song_widget.dart';
import 'package:http/http.dart' as http;
import 'song.dart';
import 'package:audioplayers/audioplayers.dart';

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
  List<Song> songs = [];
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    audioPlayer.onPlayerCompletion.listen((event) {
      print('song finished!');
    });

    performSearch('metallica');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void performSearch(String query) async {
    var url = Uri.https(
        'itunes.apple.com', '/search', {'entity': 'song', 'term': query});

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var results = json['results'];

      var foundSongs = [
        for (var song in results)
          Song(
            name: song['trackName'],
            artist: song['artistName'],
            album: song['collectionName'],
            coverUrl: song['artworkUrl100'],
            sampleUrl: song['previewUrl'],
          )
      ];

      setState(() {
        this.songs = foundSongs;
      });

      print(response.body);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listViewItems;

    listViewItems = [
      for (Song song in songs)
        SongWidget(
          song: song,
          audioPlayer: audioPlayer,
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
