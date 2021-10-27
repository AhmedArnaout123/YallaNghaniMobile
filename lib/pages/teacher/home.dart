/*
* File : Selectable List
* Version : 1.0.0
* */

import 'package:yallangany/AppThemeNotifier.dart';
import 'package:yallangany/cubits/teacher/home/teacher_cubit.dart';
import 'package:yallangany/models/day.dart';
import 'package:yallangany/models/lesson_date.dart';
import 'package:yallangany/utils/SizeConfig.dart';
import 'package:yallangany/pages/teacher/send_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart' as intl;

import 'package:yallangany/AppTheme.dart';
import 'package:yallangany/drawer/yalla_drawer.dart';

class TeacherHomeScreen extends StatefulWidget {
  @override
  _TeacherHomeScreenState createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  ThemeData themeData;
  Day _selectedDay;
  CustomAppTheme customAppTheme;

  @override
  void initState() {
    super.initState();

    _selectedDay = DayExtension.fromString(
      intl.DateFormat.E().format(DateTime.now()).toString(),
    );
    Future.delayed(Duration(seconds: 0))
        .then((value) => BlocProvider.of<TeacherCubit>(context).fetchData());
  }

  @override
  Widget build(BuildContext context) {
    TeacherCubit teacherCubit = BlocProvider.of<TeacherCubit>(context);
    themeData = Theme.of(context);
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget child) {
        customAppTheme = AppTheme.getCustomAppTheme(value.themeMode());
        return Directionality(
          textDirection: TextDirection.rtl,
          child: RefreshIndicator(
            onRefresh: () async {
              teacherCubit.fetchData();
            },
            backgroundColor: Colors.white,
            child: Scaffold(
              drawer: YallaDrawer(),
              appBar: AppBar(
                title: Text(
                  "حسابي",
                ),
              ),
              body: BlocBuilder<TeacherCubit, TeacherState>(
                builder: (context, state) {
                  if (state is TeacherHasData) {
                    List<Map<String, dynamic>> data = [];
                    for (var course in state.teacher.courses)
                      for (var lessonDate in course.lessonsDates)
                        if (lessonDate.day == _selectedDay)
                          data.add({
                            'courseTitle': course.title,
                            'studentName': course.studentName,
                            'lessonDate': lessonDate
                          });

                    data.sort((l1, l2) =>
                        l1['lessonDate'].compareTo(l2['lessonDate']));
                    return ListView(
                      padding: Spacing.fromLTRB(24, 15, 24, 15),
                      children: [
                        Row(
                          children: [
                            Text(
                              "مرحبا ${state.teacher.firstName}",
                              style: AppTheme.getTextStyle(
                                themeData.textTheme.headline5,
                                color: themeData.colorScheme.onBackground,
                                fontWeight: 600,
                              ),
                            ),
                            Spacer(),
                            ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  Spacing.xy(16, 0),
                                ),
                              ),
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SendMessageScreen(
                                    courses: state.teacher.courses,
                                    teacherName: state.teacher.firstName +
                                        ' ' +
                                        state.teacher.lastName,
                                  ),
                                ),
                              ),
                              child: Text(
                                "إرسال رسالة",
                                style: AppTheme.getTextStyle(
                                        themeData.textTheme.bodyText2,
                                        fontWeight: 600)
                                    .merge(
                                  TextStyle(
                                      color: themeData.colorScheme.onPrimary),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MySize.size8,
                        ),
                        Text(
                          "نتمنى لك يوماً سعيداً من أسرة يلا نغني",
                          style: AppTheme.getTextStyle(
                            themeData.textTheme.subtitle2,
                            letterSpacing: 0,
                            color: themeData.colorScheme.onBackground,
                            fontWeight: 500,
                            xMuted: true,
                          ),
                        ),
                        SizedBox(
                          height: MySize.size24,
                        ),
                        Image(
                          image: AssetImage(
                              './assets/illustration/music/illu-1.png'),
                          width: MySize.getScaledSizeHeight(300),
                          height: MySize.getScaledSizeHeight(320),
                        ),
                        SizedBox(
                          height: MySize.size24,
                        ),
                        Row(
                          children: [
                            Text(
                              "جدول الدروس :",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: 150,
                              child: DropdownButton<Day>(
                                dropdownColor: customAppTheme.bgLayer1,
                                value: _selectedDay,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedDay = value;
                                  });
                                },
                                items: Day.values
                                    .map(
                                      (e) => DropdownMenuItem<Day>(
                                        child: Text(
                                          e.toArabic(),
                                        ),
                                        value: e,
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                          ],
                        ),
                        for (var item in data)
                          _buildSingleLesson(
                            courseName: item['courseTitle'],
                            studentName: item['studentName'],
                            hour: item['lessonDate'].hour,
                          ),
                      ],
                    );
                  }
                  if (state is TeacherIsLoading || state is TeacherInitial) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('حدث خطأ أثناء جلب البيانات'),
                        ElevatedButton(
                          child: Text('إعادة تحميل'),
                          onPressed: () {
                            teacherCubit.fetchData();
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSingleLesson(
      {String studentName, String courseName, String hour}) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: 14),
      child: Container(
        color: Color(0xfff3f3f3),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: themeData.colorScheme.secondary.withAlpha(240),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(
                child: Text(
                  hour,
                  style: AppTheme.getTextStyle(
                    themeData.textTheme.bodyText1,
                    fontWeight: 600,
                    color: themeData.colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ),
          // subtitle: Text(
          //   courseName,
          //   style: AppTheme.getTextStyle(
          //     themeData.textTheme.bodyText2,
          //     fontWeight: 500,
          //     color: themeData.colorScheme.onBackground,
          //   ),
          // ),
          title: Text(
            studentName,
            style: AppTheme.getTextStyle(
              themeData.textTheme.headline6,
              fontWeight: 600,
            ),
          ),
        ),
      ),
    );
  }
}
