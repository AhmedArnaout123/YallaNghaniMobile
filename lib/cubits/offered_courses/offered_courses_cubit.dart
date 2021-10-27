import 'dart:convert';

import 'package:yallangany/helpers/const_data_helper.dart';
import 'package:yallangany/models/general/offered_course.dart';
import 'package:yallangany/services/api_connection/api_connection_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'offered_courses_state.dart';

class OfferedCoursesCubit extends Cubit<OfferedCoursesState> {
  OfferedCoursesCubit() : super(OfferedCoursesInitial());

  String get offeredCoursesPathUrl =>
      '${ConstDataHelper.baseUrl}/offeredcourses';

  void fetchData() async {
    ///
    emit(OfferedCoursesIsLoading());

    ///
    var requestResult = await ApiCaller.request(
      method: HttpMethod.GET,
      url: '$offeredCoursesPathUrl',
      headers: ConstDataHelper.apiCommonHeaders,
    );

    if (requestResult is Ok) {
      ///
      var offeredCourses = json.decode(requestResult.body)['outcome'];
      if (offeredCourses != null) {
        offeredCourses = offeredCourses
            .map<OfferedCourse>((oc) => OfferedCourse.fromMap(oc))
            .toList();

        emit(OfferedCoursesHasData(offeredCourses));
        return;

        ///
      }
    }

    print(
      'An Error Accoured : ${requestResult.runtimeType}, Available Detailes: ${requestResult.toString()}',
    );
    emit(OfferedCoursesError());
  }
}
