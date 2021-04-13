import 'package:flutter/material.dart';

// The text field for searching the songs
class SearchWidget extends StatelessWidget {
  final Function onSubmitted;
  final TextEditingController controller;

  const SearchWidget({this.onSubmitted, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Search artist',
        ),
      ),
    );
  }
}
