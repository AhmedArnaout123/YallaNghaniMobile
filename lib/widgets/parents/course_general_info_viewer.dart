import 'package:flutter/material.dart';
import 'package:yallangany/models/parents/course.dart';
import 'package:yallangany/widgets/parents/dynamic_info_viewer.dart';
import 'package:yallangany/widgets/parents/info_card.dart';
import 'package:yallangany/widgets/parents/static_info_viewer.dart';

class CourseGeneralInfoViewer extends StatelessWidget {
  const CourseGeneralInfoViewer({Key key, this.course}) : super(key: key);

  final Course course;
  @override
  Widget build(BuildContext context) {
    return InfoCard(
      infoList: [
        StaticInfoViewer(
          title: 'اسم الطالب/ة',
          value: course.studentName,
        ),
        StaticInfoViewer(
          value: course.title,
          title: "الدورة",
        ),
        StaticInfoViewer(title: 'المعلم/ة', value: course.teacherName),
        StaticInfoViewer(
          title: 'تكلفة الدرس',
          value: "${course.lessonFee}\₪",
        ),
        course.parentBalance > 0
            ? DyanmicInfoViewer(
                title: 'الرصيد',
                value: '\₪${course.parentBalance}',
                color: course.parentBalance < 0 ? Colors.red : Colors.green,
              )
            : Row(
                children: [
                  Text(
                    'الرصيد : ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${course.parentBalance}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    '\₪',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
