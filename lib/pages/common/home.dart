import 'package:yallangany/cubits/offered_courses/offered_courses_cubit.dart';
import 'package:yallangany/models/general/offered_course.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

import 'package:yallangany/AppTheme.dart';

import 'package:yallangany/AppThemeNotifier.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:yallangany/services/notifications/notifications_service.dart';
import 'offered_course.dart';

import 'package:yallangany/drawer/yalla_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ThemeData themeData;

  Widget build(BuildContext context) {
    var offeredCoursesCubit = BlocProvider.of<OfferedCoursesCubit>(context);
    offeredCoursesCubit.fetchData();

    return Consumer<AppThemeNotifier>(
        builder: (BuildContext context, AppThemeNotifier value, Widget child) {
      int themeType = value.themeMode();
      themeData = AppTheme.getThemeFromThemeMode(themeType);
      return Directionality(
        textDirection: TextDirection.rtl,
        child: RefreshIndicator(
          backgroundColor: Colors.white,
          onRefresh: () async {
            offeredCoursesCubit.fetchData();
          },
          child: Scaffold(
              drawer: YallaDrawer(),
              appBar: AppBar(
                title: Text('معهد يلا نغني للموسيقى والفنون'),
                centerTitle: true,
              ),
              body: BlocBuilder<OfferedCoursesCubit, OfferedCoursesState>(
                builder: (context, state) {
                  if (state is OfferedCoursesHasData) {
                    return ListView(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.red.withOpacity(0.2),
                          child: Carousel(
                            indicatorBgPadding: 10,
                            dotSize: 8,
                            dotIncreasedColor: Colors.blue,
                            dotIncreaseSize: 2,
                            boxFit: BoxFit.fitHeight,
                            images: [
                              Image(
                                fit: BoxFit.fill,
                                image:
                                    AssetImage('./assets/images/slider/1.jpg'),
                              ),
                              Image(
                                fit: BoxFit.fill,
                                image:
                                    AssetImage('./assets/images/slider/2.jpg'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                            "الدورات التعليمية",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 150,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...state.offeredCourses
                                  .where((course) => course.isEducational)
                                  .map((course) =>
                                      titghtCourse(offeredCourse: course))
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.blue,
                          thickness: 3,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "العلاجات بالتعاون مع כללית מושלם",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...state.offeredCourses
                            .where((e) => !e.isEducational)
                            .map(
                              (e) => wideCourse(offeredCourse: e),
                            )
                            .toList(),
                        SizedBox(height: 20),
                      ],
                    );
                  }

                  if (state is OfferedCoursesIsLoading ||
                      state is OfferedCoursesInitial) {
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
                            offeredCoursesCubit.fetchData();
                          },
                        )
                      ],
                    ),
                  );
                },
              )),
        ),
      );
    });
  }

  Widget titghtCourse({OfferedCourse offeredCourse}) {
    var imageId = offeredCourse.imageUrl.substring(32);
    imageId = imageId.substring(0, imageId.indexOf('/'));
    var imageUrl = 'https://drive.google.com/uc?export=view&id=$imageId';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OfferedCourseScreen(offeredCourse: offeredCourse),
          ),
        );
      },
      child: Container(
        height: 100,
        width: 100,
        child: ListTile(
          title: Image.network(
            imageUrl,
            height: 100,
            width: 100,
          ),
          subtitle: Container(
            child: Text(
              offeredCourse.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget wideCourse({OfferedCourse offeredCourse, onTap}) {
    var imageId = offeredCourse.imageUrl.substring(32);
    imageId = imageId.substring(0, imageId.indexOf('/'));
    var imageUrl = 'https://drive.google.com/uc?export=view&id=$imageId';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OfferedCourseScreen(
              offeredCourse: offeredCourse,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Image(
            width: MediaQuery.of(context).size.width,
            image: NetworkImage(
              imageUrl,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.3),
              alignment: Alignment.center,
              child: Text(
                offeredCourse.title,
                style: AppTheme.getTextStyle(
                  themeData.textTheme.headline5,
                  fontWeight: 600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
