import 'package:flutter/material.dart';
import 'package:sample_player_app/components/search_widget.dart';
import 'package:sample_player_app/components/song_widget.dart';
import 'package:sample_player_app/song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sample_player_app/song_finder.dart';
import 'package:sample_player_app/components/player_control_widget.dart';

class PlaylistScreen extends StatefulWidget {
  PlaylistScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  TextEditingController _searchController;

  // player related
  List<Song> songs = [];
  AudioPlayer player;
  bool isPlaying = false;
  bool showPlayer = false;
  Song currentSong;

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
        showPlayer = true;
        currentSong = song;
      });
    }
  }

  pause() async {
    await player.pause();

    setState(() {
      isPlaying = false;
    });
  }

  resume() async {
    await player.resume();

    setState(() {
      isPlaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listViewItems;

    listViewItems = [
      for (Song song in songs)
        SongWidget(
          song: song,
          isPlaying: (song == currentSong && isPlaying),
          onPlay: (Song song) {
            play(song, context);
          },
        )
    ];

    List<Widget> widgets = [
      SearchWidget(
        onSubmitted: (String query) {
          performSearch(query);
        },
        controller: _searchController,
      )
    ];

    if (songs.isEmpty) {
      widgets.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'To start, search for songs/artists in the input above!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      widgets.add(
        Expanded(
          child: ListView(
            children: listViewItems,
          ),
        ),
      );
    }

    if (showPlayer) {
      widgets.add(
        PlayerControlWidget(
          onPause: () {
            pause();
          },
          onPlay: () {
            resume();
          },
          isPlaying: isPlaying,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: widgets,
        ),
      ),
    );
  }
}
