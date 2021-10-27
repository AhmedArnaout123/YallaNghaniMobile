import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallangany/cubits/main_page/main_page_cubit.dart';
import 'package:yallangany/pages/common/home.dart';
import 'package:yallangany/pages/parent/home.dart';
import 'package:yallangany/pages/teacher/home.dart';

class MainPageBlocBuilder extends StatelessWidget {
  const MainPageBlocBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageCubit, MainPageState>(builder: (context, state) {
      if (state is ParentHomePage) return ParentHomeScreen();

      if (state is TeacherHomePage) return TeacherHomeScreen();

      return HomeScreen();
    });
  }
}
