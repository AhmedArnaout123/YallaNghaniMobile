import 'dart:convert';

import 'package:yallangany/helpers/const_data_helper.dart';
import 'package:yallangany/models/parents/parent.dart';
import 'package:yallangany/providers/user_identity_provider.dart';
import 'package:yallangany/services/api_connection/api_connection_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yallangany/services/notifications/notifications_service.dart';

part 'parent_state.dart';

class ParentCubit extends Cubit<ParentState> {
  ///
  ParentCubit() : super(ParentInitial());

  String get parentPathUrl =>
      '${ConstDataHelper.baseUrl}/parents/${UserIdentityProvieder().getId()}';

  void fetchData() async {
    ///
    emit(ParentIsLoading());

    ///
    var requestResult = await ApiCaller.request(
      method: HttpMethod.GET,
      url: '$parentPathUrl',
      headers: ConstDataHelper.apiCommonHeaders,
    );

    if (requestResult is Ok) {
      ///
      var parentData = json.decode(requestResult.body)['outcome'];
      if (parentData != null) {
        Parent parent = Parent.fromMap(parentData);
        if (parent.hasLessonsDatesUpdate) {
          await NotificationService().cancelAll();
          parent.courses.forEach((course) {
            course.lessonsDates.forEach((ld) async {
              await NotificationService().schdeule(
                course.studentName,
                course.title,
                ld.hour,
                ld.getNotificationTime(),
              );
              print(
                'Registerd Notification At ${ld.getNotificationTime()} for Lesson Date $ld',
              );
            });
          });
          await ApiCaller.request(
            url: '$parentPathUrl/ConsumeLessonsDatesUpdate',
            method: HttpMethod.POST,
            headers: ConstDataHelper.apiCommonHeaders,
          );
        }

        emit(ParentHasData(parent));
        return;

        ///
      }
    }

    print(
      'An Error Accoured : ${requestResult.runtimeType}, Available Detailes: ${requestResult.toString()}',
    );
    emit(ParentError());
  }

  void resetNewMessagesCounter() async {
    while (true) {
      ///
      var requestResult = await ApiCaller.request(
        method: HttpMethod.POST,
        url: '$parentPathUrl/resetnewmessagescount',
        headers: ConstDataHelper.apiCommonHeaders,
      );

      if (requestResult is Ok) break;

      await Future.delayed(Duration(seconds: 30));
    }
    if (state is ParentHasData) {
      var parent = (state as ParentHasData).parent;
      parent.newMessagesCount = 0;
      emit(ParentHasData(parent));
    }
  }

  void reset() {
    emit(ParentInitial());
  }
}
