import 'package:yallangany/models/general/offered_course.dart';
import 'package:yallangany/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:yallangany/AppTheme.dart';
import 'package:yallangany/AppThemeNotifier.dart';

class OfferedCourseScreen extends StatefulWidget {
  final OfferedCourse offeredCourse;

  const OfferedCourseScreen({Key key, this.offeredCourse}) : super(key: key);
  @override
  _OfferedCourseScreenState createState() => _OfferedCourseScreenState();
}

class _OfferedCourseScreenState extends State<OfferedCourseScreen> {
  ThemeData themeData;
  CustomAppTheme customAppTheme;
  bool isFav = true;

  bool isBookmark = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget child) {
        int themeType = value.themeMode();
        themeData = AppTheme.getThemeFromThemeMode(themeType);
        customAppTheme = AppTheme.getCustomAppTheme(themeType);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.offeredCourse.title),
              centerTitle: true,
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: MediaQuery.of(context).padding.top + 10,
              ),
              children: <Widget>[
                Image(
                  image: AssetImage('./assets/illustration/music/illu-4.png'),
                ),
                buildTitle(widget.offeredCourse.title),
                Container(
                  // padding: Spacing.fromLTRB(36, 0, 36, 0),
                  margin: Spacing.top(10),
                  child: Text(
                    widget.offeredCourse.description,
                    style: AppTheme.getTextStyle(
                      themeData.textTheme.bodyText2,
                      color: themeData.colorScheme.onBackground,
                      fontWeight: 500,
                      letterSpacing: 0.3,
                      height: 1.4,
                    ),
                  ),
                ),
                buildTitle('المعلم/ة: ${widget.offeredCourse.teacherName}'),
                Container(child: Text(widget.offeredCourse.teacherDescription)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTitle(String title) {
    return Container(
      margin: Spacing.top(16),
      child: Text(
        title,
        style: AppTheme.getTextStyle(
          themeData.textTheme.headline5,
          fontWeight: 700,
        ),
      ),
    );
  }
}
