/*
* File : Main File
* Version : 1.0.0
* */

import 'package:yallangany/AppTheme.dart';
import 'package:yallangany/AppThemeNotifier.dart';
import 'package:yallangany/cubits/main_page/main_page_cubit.dart';
import 'package:yallangany/cubits/offered_courses/offered_courses_cubit.dart';
import 'package:yallangany/cubits/identifier/identifier_cubit.dart';
import 'package:yallangany/cubits/parent/parent_cubit.dart';
import 'package:yallangany/cubits/teacher/home/teacher_cubit.dart';
import 'package:yallangany/cubits/teacher/msseages_sender/messagessender_cubit.dart';
import 'package:yallangany/services/notifications/notifications_service.dart';
import 'package:yallangany/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:yallangany/widgets/identity_bloc_builder.dart';

void main() {
  //You will need to initialize AppThemeNotifier class for theme changes.
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    WidgetsFlutterBinding.ensureInitialized();
    await NotificationService().init();
    runApp(ChangeNotifierProvider<AppThemeNotifier>(
      create: (context) => AppThemeNotifier(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ParentCubit()),
          BlocProvider(create: (context) => TeacherCubit()),
          BlocProvider(create: (context) => MessagesSenderCubit()),
          BlocProvider(
            create: (context) => IdentifierCubit()..checkForIdentity(),
          ),
          BlocProvider(create: (context) => OfferedCoursesCubit()..fetchData()),
          BlocProvider(create: (context) => MainPageCubit())
        ],
        child: MyApp(),
      ),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeFromThemeMode(value.themeMode()),
          home: Builder(builder: (context) {
            MySize().init(context);
            return IdentifierBlocBuilder();
          }),
        );
      },
    );
  }
}
