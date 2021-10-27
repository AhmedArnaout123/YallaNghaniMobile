import 'dart:convert';

import 'package:yallangany/helpers/const_data_helper.dart';
import 'package:yallangany/models/parents/message.dart';
import 'package:yallangany/services/api_connection/api_connection_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'messagessender_state.dart';

class MessagesSenderCubit extends Cubit<MessagesSenderState> {
  MessagesSenderCubit() : super(MessagesSenderInitial());

  void sendMessages(Message message, String id) async {
    ///
    emit(MessagesSenderIsLoading());

    ///
    message.date = message.date.split(' ')[0];

    var result = await ApiCaller.request(
      url: '${ConstDataHelper.baseUrl}/parents/$id/messages',
      method: HttpMethod.POST,
      headers: ConstDataHelper.apiCommonHeaders,
      body: jsonEncode(message.toMap()),
    );

    if (result is Ok)
      emit(MessagesSenderSuccess());
    else
      emit(MessagesSenderFailure());
  }

  void reset() {
    emit(MessagesSenderInitial());
  }
}
