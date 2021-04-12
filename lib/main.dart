import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'song_widget.dart';
import 'package:http/http.dart' as http;
import 'song.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// MediaQuery.of()

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController;
  List<Song> songs = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    performSearch('metallica');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void performSearch(String query) async {
    //String encQuery = Uri.encodeComponent(query);

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

    listViewItems = [for (Song song in songs) SongWidget(song: song)];
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
