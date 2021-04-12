import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SongWidget extends StatelessWidget {
  final String songName;
  final String artistName;
  final String albumName;

  const SongWidget({this.songName, this.artistName, this.albumName});

  void playSong(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () {
          playSong(context);
        },
        child: Container(
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://cdn.shopify.com/s/files/1/0024/9803/5810/products/549076-Product-0-I_1080x.jpg',
                width: 100.0,
                height: 100.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          songName,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          artistName,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Text(albumName),
                    ],
                  ),
                ),
              ),
              SpinKitWave(
                color: Colors.black,
                size: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerControlWidget extends StatelessWidget {
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
