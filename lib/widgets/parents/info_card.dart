import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({Key key, this.infoList}) : super(key: key);

  final List<Widget> infoList;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xfff2f2f2),
      elevation: 8,
      margin: EdgeInsets.only(bottom: 18),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: infoList,
        ),
      ),
    );
  }
}
