import 'package:flutter/material.dart';
import 'package:yallangany/models/parents/lesson.dart';
import 'package:yallangany/widgets/parents/info_card.dart';
import 'package:yallangany/widgets/parents/static_info_viewer.dart';

import 'dynamic_info_viewer.dart';

class LessonViewer extends StatelessWidget {
  const LessonViewer({Key key, this.lesson}) : super(key: key);

  final Lesson lesson;
  @override
  Widget build(BuildContext context) {
    return InfoCard(
      infoList: [
        StaticInfoViewer(
          title: 'رقم الدرس',
          value: lesson.number.toString(),
        ),
        StaticInfoViewer(
          title: 'التاريخ',
          value: lesson.date,
        ),
        StaticInfoViewer(
          title: 'تكلفة الدرس',
          value: '${lesson.fee}\₪',
        ),
        DyanmicInfoViewer(
          title: "الحالة",
          value: lesson.paymentStatus.toArabic(),
          color: lesson.paymentStatus.isPaied ? Colors.green : Colors.red,
        ),
        if (lesson.paymentNote != null && lesson.paymentNote.isNotEmpty)
          StaticInfoViewer(
            title: 'ملاحظة عن الدفع',
            value: lesson.paymentNote,
          )
      ],
    );
  }
}
