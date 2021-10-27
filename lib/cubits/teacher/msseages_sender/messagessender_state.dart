part of 'messagessender_cubit.dart';

@immutable
abstract class MessagesSenderState {}

class MessagesSenderInitial extends MessagesSenderState {}

class MessagesSenderIsLoading extends MessagesSenderState {}

class MessagesSenderSuccess extends MessagesSenderState {}

class MessagesSenderFailure extends MessagesSenderState {
  MessagesSenderFailure();
}
