part of 'offered_courses_cubit.dart';

@immutable
abstract class OfferedCoursesState {}

class OfferedCoursesInitial extends OfferedCoursesState {}

class OfferedCoursesHasData extends OfferedCoursesState {
  final List<OfferedCourse> offeredCourses;

  OfferedCoursesHasData(this.offeredCourses);
}

class OfferedCoursesError extends OfferedCoursesState {}

class OfferedCoursesIsLoading extends OfferedCoursesState {}
