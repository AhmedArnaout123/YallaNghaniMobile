import 'package:yallangany/models/parents/course.dart';
import 'package:flutter/material.dart';
import 'package:yallangany/pages/parent/lessons.dart';
import 'package:yallangany/pages/parent/lessons_dates.dart';
import 'package:yallangany/pages/parent/payments.dart';
import 'package:yallangany/widgets/parents/course_general_info_viewer.dart';
import 'package:yallangany/widgets/parents/lesson_date_viewer.dart';
import 'package:yallangany/widgets/parents/lesson_viewer.dart';
import 'package:yallangany/widgets/parents/payment_viewer.dart';
import 'package:yallangany/widgets/parents/title_viewer.dart';

class EnrolledCourseScreen extends StatelessWidget {
  final Course course;

  const EnrolledCourseScreen({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(course.title),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: MediaQuery.of(context).padding.top,
          ),
          children: [
            Container(
              child: Image(
                image: AssetImage('./assets/illustration/music/illu-3.png'),
              ),
            ),
            SizedBox(height: 10),
            TitleViewer(title: 'معلومات عامة'),
            SizedBox(height: 10),
            CourseGeneralInfoViewer(course: course),
            SizedBox(height: 10),
            _buildTitleWithNavigator(
              title: 'الدفعات',
              toPage: PaymentsPage(
                payments: course.payments,
              ),
              context: context,
            ),
            SizedBox(height: 10),
            for (var payment in course.payments.take(2))
              PaymentViewer(payment: payment),
            SizedBox(height: 10),
            _buildTitleWithNavigator(
              title: 'الدروس',
              toPage: LessonsPage(
                lessons: course.lessons,
              ),
              context: context,
            ),
            SizedBox(height: 10),
            for (var lesson in course.lessons.take(2))
              LessonViewer(lesson: lesson),
            SizedBox(height: 16),
            _buildTitleWithNavigator(
              title: 'المواعيد',
              toPage: LessonsDatesPage(lessonDates: course.lessonsDates),
              context: context,
            ),
            SizedBox(height: 10),
            for (var lessonDate in course.lessonsDates.take(2))
              LessonDateViewer(lessonDate: lessonDate),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleWithNavigator({context, title, toPage}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleViewer(title: title),
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => toPage));
          },
          child: Text('عرض الكل'),
        )
      ],
    );
  }
}
