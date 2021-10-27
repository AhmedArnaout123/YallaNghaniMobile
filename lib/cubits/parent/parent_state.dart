part of 'parent_cubit.dart';

@immutable
abstract class ParentState {}

class ParentInitial extends ParentState {}

class ParentHasData extends ParentState {
  final Parent parent;

  ParentHasData(this.parent);
}

class ParentError extends ParentState {}

class ParentIsLoading extends ParentState {}
