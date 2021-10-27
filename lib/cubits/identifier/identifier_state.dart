part of 'identifier_cubit.dart';

@immutable
abstract class IdentifierState {}

class IdentifierInitial extends IdentifierState {}

class IdentifierIdentityExist extends IdentifierState {
  final String role;

  IdentifierIdentityExist(this.role);
}

class IdentifierIdentityNotExist extends IdentifierState {}
