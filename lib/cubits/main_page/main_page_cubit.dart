import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(MainPageInitial());

  void goToCommonHomePage() {
    if (state is CommonHomePage) {
      return;
    }

    emit(CommonHomePage());
  }

  void goToParentHomePage() {
    if (state is ParentHomePage) return;

    emit(ParentHomePage());
  }

  void goToTeahcerHomePage() {
    if (state is TeacherHomePage) return;

    emit(TeacherHomePage());
  }
}
