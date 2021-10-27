part of 'teacher_cubit.dart';

@immutable
abstract class TeacherState {}

class TeacherInitial extends TeacherState {}

class TeacherHasData extends TeacherState {
  final Teacher teacher;

  TeacherHasData(this.teacher);
}

class TeacherError extends TeacherState {}

class TeacherIsLoading extends TeacherState {}
