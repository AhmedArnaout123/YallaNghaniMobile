import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallangany/cubits/identifier/identifier_cubit.dart';
import 'package:yallangany/cubits/main_page/main_page_cubit.dart';
import 'package:yallangany/pages/common/splashscreen.dart';
import 'package:yallangany/widgets/main_page_bloc_builder.dart';

class IdentifierBlocBuilder extends StatelessWidget {
  final IdentifierCubit bloc;
  final Widget child;
  const IdentifierBlocBuilder({this.child, this.bloc, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IdentifierCubit, IdentifierState>(
      builder: (context, state) {
        if (state is IdentifierInitial) {
          return SplashScreen();
        }
        var mainPageCubit = BlocProvider.of<MainPageCubit>(context);
        if (state is IdentifierIdentityExist) {
          if (state.role == 'parent')
            mainPageCubit.goToParentHomePage();
          else
            mainPageCubit.goToTeahcerHomePage();
        } else if (state is IdentifierIdentityNotExist)
          mainPageCubit.goToCommonHomePage();

        return MainPageBlocBuilder();
      },
    );
  }
}
