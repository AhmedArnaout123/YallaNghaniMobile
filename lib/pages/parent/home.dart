/*
* File : Selectable List
* Version : 1.0.0
* */

import 'package:yallangany/AppThemeNotifier.dart';
import 'package:yallangany/cubits/parent/parent_cubit.dart';
import 'package:yallangany/utils/SizeConfig.dart';
import 'package:yallangany/pages/parent/enrolled_course.dart';
import 'package:yallangany/pages/parent/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'package:yallangany/AppTheme.dart';
import 'package:yallangany/drawer/yalla_drawer.dart';

class ParentHomeScreen extends StatefulWidget {
  @override
  _ParentHomeScreenState createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  ///
  ThemeData themeData;
  CustomAppTheme customAppTheme;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0))
        .then((value) => BlocProvider.of<ParentCubit>(context).fetchData());
  }

  @override
  Widget build(BuildContext context) {
    ParentCubit parentCubit = BlocProvider.of<ParentCubit>(context);
    themeData = Theme.of(context);
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget child) {
        customAppTheme = AppTheme.getCustomAppTheme(value.themeMode());
        return Directionality(
          textDirection: TextDirection.rtl,
          child: RefreshIndicator(
            backgroundColor: Colors.white,
            onRefresh: () async {
              parentCubit.fetchData();
            },
            child: Scaffold(
              drawer: YallaDrawer(),
              appBar: AppBar(
                title: Text(
                  "حسابي",
                ),
              ),
              body: BlocBuilder<ParentCubit, ParentState>(
                builder: (context, state) {
                  if (state is ParentHasData) {
                    int coursesCounter = 0;
                    return ListView(
                      padding: Spacing.fromLTRB(24, 15, 24, 15),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "مرحبا ${state.parent.firstName}",
                              style: AppTheme.getTextStyle(
                                themeData.textTheme.headline5,
                                color: themeData.colorScheme.onBackground,
                                fontWeight: 600,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                parentCubit.resetNewMessagesCounter();
                                Navigator.of(context).push(
                                  new MaterialPageRoute<Null>(
                                    builder: (BuildContext context) {
                                      return MessagesScreen(
                                        messages: state.parent.messages,
                                      );
                                    },
                                    fullscreenDialog: true,
                                  ),
                                );
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                  Icon(
                                    Feather.message_circle,
                                    size: MySize.size36,
                                    color: themeData.colorScheme.onBackground
                                        .withAlpha(200),
                                  ),
                                  if (state.parent.newMessagesCount > 0)
                                    Positioned(
                                      right: -2,
                                      top: -2,
                                      child: Container(
                                        padding: Spacing.zero,
                                        height: MySize.size20,
                                        width: MySize.size20,
                                        decoration: BoxDecoration(
                                          color: Color(0xff407bff),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(MySize.size40),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${state.parent.newMessagesCount}",
                                            style: AppTheme.getTextStyle(
                                              themeData.textTheme.overline,
                                              color: customAppTheme
                                                  .onGroceryPrimaryColor,
                                              fontSize: 9,
                                              fontWeight: 500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            )
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
                        for (var course in state.parent.courses)
                          _buildSingleCourse(
                              number: '${++coursesCounter}',
                              student: course.studentName,
                              course: course.title,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      EnrolledCourseScreen(course: course),
                                ));
                              }),
                      ],
                    );
                  }
                  if (state is ParentIsLoading || state is ParentInitial) {
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
                            parentCubit.fetchData();
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

  Widget _buildSingleCourse(
      {String number, String student, String course, onTap}) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(bottom: 14),
      child: Container(
        color: Color(0xfff3f3f3),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: themeData.colorScheme.secondary.withAlpha(240),
            child: Text(
              number,
              style: AppTheme.getTextStyle(
                themeData.textTheme.bodyText1,
                fontWeight: 600,
                color: themeData.colorScheme.onSecondary,
              ),
            ),
          ),
          subtitle: Text(
            student,
            style: AppTheme.getTextStyle(
              themeData.textTheme.bodyText2,
              fontWeight: 500,
              color: themeData.colorScheme.onBackground,
            ),
          ),
          title: Text(
            course,
            style: AppTheme.getTextStyle(
              themeData.textTheme.headline6,
              fontWeight: 600,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
