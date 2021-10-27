import 'package:yallangany/providers/user_identity_provider.dart';
import 'package:yallangany/services/storage_service/storage_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'identifier_state.dart';

class IdentifierCubit extends Cubit<IdentifierState> {
  IdentifierCubit() : super(IdentifierInitial());

  Future<void> checkForIdentity() async {
    ///
    var role = await StorageService().read('role');
    var id = await StorageService().read('id');
    var token = await StorageService().read('token');

    ///
    if (role != null && id != null && token != null) {
      ///
      UserIdentityProvieder().setIdentity(role, id, token);

      var firstName = await StorageService().read('firstName');
      var lastName = await StorageService().read('lastName');
      var phoneNumber = await StorageService().read('phoneNumber');

      UserIdentityProvieder().setAccountInfo(firstName, lastName, phoneNumber);

      await Future.delayed(Duration(seconds: 1));
      emit(IdentifierIdentityExist(role));

      ///
    } else {
      await Future.delayed(Duration(seconds: 1));
      emit(IdentifierIdentityNotExist());
    }
  }

  void removeIdentity() async {
    await StorageService().remove('token');
    await StorageService().remove('id');
    await StorageService().remove('role');
    await StorageService().remove('firstName');
    await StorageService().remove('lastName');
    await StorageService().remove('phoneNumber');

    UserIdentityProvieder().reset();

    emit(IdentifierIdentityNotExist());
  }

  void identify(String role) {
    emit(IdentifierIdentityExist(role));
  }
}
