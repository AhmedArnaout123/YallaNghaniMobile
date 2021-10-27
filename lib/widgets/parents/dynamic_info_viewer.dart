import 'package:flutter/material.dart';

class DyanmicInfoViewer extends StatelessWidget {
  const DyanmicInfoViewer(
      {Key key, @required this.title, @required this.value, this.color})
      : super(key: key);

  final String title, value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title :',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(color: color, fontSize: 18),
        ),
      ],
    );
  }
}
