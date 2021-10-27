import 'package:flutter/material.dart';
import 'package:yallangany/models/parents/lesson.dart';
import 'package:yallangany/widgets/parents/lesson_viewer.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({Key key, this.lessons}) : super(key: key);

  final List<Lesson> lessons;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الدروس'),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: lessons
              .map(
                (lesson) => LessonViewer(lesson: lesson),
              )
              .toList(),
        ),
      ),
    );
  }
}
