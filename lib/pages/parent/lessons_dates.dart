import 'package:flutter/material.dart';
import 'package:yallangany/models/lesson_date.dart';
import 'package:yallangany/widgets/parents/lesson_date_viewer.dart';

class LessonsDatesPage extends StatelessWidget {
  const LessonsDatesPage({Key key, this.lessonDates}) : super(key: key);

  final List<LessonDate> lessonDates;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('المواعيد'),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: lessonDates
              .map(
                (lessonDate) => LessonDateViewer(lessonDate: lessonDate),
              )
              .toList(),
        ),
      ),
    );
  }
}
