import 'package:flutter/material.dart';

class TitleViewer extends StatelessWidget {
  const TitleViewer({Key key, this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
    );
  }
}
