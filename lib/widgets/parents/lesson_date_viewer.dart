import 'package:flutter/material.dart';
import 'package:yallangany/models/lesson_date.dart';
import 'package:yallangany/widgets/parents/info_card.dart';
import 'package:yallangany/widgets/parents/static_info_viewer.dart';

class LessonDateViewer extends StatelessWidget {
  const LessonDateViewer({Key key, this.lessonDate}) : super(key: key);

  final LessonDate lessonDate;
  @override
  Widget build(BuildContext context) {
    return InfoCard(
      infoList: [
        StaticInfoViewer(
          title: 'اليوم',
          value: "${lessonDate.day.toArabic()}",
        ),
        StaticInfoViewer(
          title: 'الساعة',
          value: lessonDate.hour,
        ),
      ],
    );
  }
}
