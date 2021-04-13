import 'song.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Finds a list of songs from iTunes api
// and returns them as a list of Songs.
class SongFinder {
  static Future<List<Song>> findBy(String query) async {
    var url = Uri.https(
        'itunes.apple.com', '/search', {'entity': 'song', 'term': query});

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var results = json['results'];

      List<Song> foundSongs = [
        for (var song in results)
          Song(
            name: song['trackName'],
            artist: song['artistName'],
            album: song['collectionName'],
            coverUrl: song['artworkUrl100'],
            sampleUrl: song['previewUrl'],
          )
      ];

      return foundSongs;
    }

    // TODO: handle error here/make it null safe
    return null;
  }
}
