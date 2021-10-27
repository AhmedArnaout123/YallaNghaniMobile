import 'package:flutter/material.dart';

class StaticInfoViewer extends StatelessWidget {
  const StaticInfoViewer({Key key, @required this.title, @required this.value})
      : super(key: key);

  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Text(
      '$title : $value',
      style: TextStyle(fontSize: 18),
    );
  }
}
