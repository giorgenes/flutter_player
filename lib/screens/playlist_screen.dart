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

  // perform the query on iTunes and update the state with new songs
  void performSearch(String query) async {
    var foundSongs = await SongFinder.findBy(query);

    setState(() {
      this.songs = foundSongs;
    });
  }

  // starts playing the selected song
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

  // pause the current song
  pause() async {
    await player.pause();

    setState(() {
      isPlaying = false;
    });
  }

  // resume playing the current song
  resume() async {
    await player.resume();

    setState(() {
      isPlaying = true;
    });
  }

  // creates the song list widgets from the existing
  // song list
  List<Widget> buildSongWidgets() {
    return ([
      for (Song song in songs)
        SongWidget(
          song: song,
          isPlaying: (song == currentSong && isPlaying),
          onPlay: (Song song) {
            play(song, context);
          },
        )
    ]);
  }

  // search input widget
  Widget buildSearchWidget() => SearchWidget(
        onSubmitted: (String query) {
          performSearch(query);
        },
        controller: _searchController,
      );

  // Empty list placeholder message
  Widget buildEmptyPlaceholder() => Expanded(
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
      );

  // Song List view widget
  Widget buildSongList() => Expanded(
        child: ListView(
          children: buildSongWidgets(),
        ),
      );

  // Builds the bottom player controller widget
  Widget buildControlWidget() => PlayerControlWidget(
        onPause: () {
          pause();
        },
        onPlay: () {
          resume();
        },
        isPlaying: isPlaying,
      );

  @override
  Widget build(BuildContext context) {
    // Start with the search bar...
    List<Widget> widgets = [buildSearchWidget()];

    // Adds the song list or the placeholder message
    if (songs.isEmpty) {
      widgets.add(buildEmptyPlaceholder());
    } else {
      widgets.add(buildSongList());
    }

    // if player control is visible, add it
    if (showPlayer) {
      widgets.add(buildControlWidget());
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
