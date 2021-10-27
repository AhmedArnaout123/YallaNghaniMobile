import 'dart:convert';

import 'package:yallangany/helpers/const_data_helper.dart';
import 'package:yallangany/models/teachers/teacher.dart';
import 'package:yallangany/providers/user_identity_provider.dart';
import 'package:yallangany/services/api_connection/api_connection_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yallangany/services/notifications/notifications_service.dart';

part 'teacher_state.dart';

class TeacherCubit extends Cubit<TeacherState> {
  TeacherCubit() : super(TeacherInitial());

  String get teacherPathUrl =>
      '${ConstDataHelper.baseUrl}/teachers/${UserIdentityProvieder().getId()}';

  void fetchData() async {
    ///
    emit(TeacherIsLoading());

    ///
    var requestResult = await ApiCaller.request(
      method: HttpMethod.GET,
      url: '$teacherPathUrl',
      headers: ConstDataHelper.apiCommonHeaders,
    );

    if (requestResult is Ok) {
      ///
      var teacherData = json.decode(requestResult.body)['outcome'];
      if (teacherData != null) {
        Teacher teacher = Teacher.fromMap(teacherData);

        // teacher.courses.forEach((course) {
        //   course.lessonsDates.forEach((ld) async {
        //     await NotificationService().cancelAll();
        //     await NotificationService().schdeule(
        //       course.studentName,
        //       course.title,
        //       ld.hour,
        //       ld.getNotificationTime(),
        //     );
        //     print(
        //       'Registerd Notification At ${ld.getNotificationTime()} for Lesson Date $ld',
        //     );
        //   });
        // });

        emit(TeacherHasData(teacher));
        return;

        ///
      }
    }

    print('An Error Accoured : ${requestResult.runtimeType}');
    emit(TeacherError());
  }

  void reset() {
    emit(TeacherInitial());
  }
}
