import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<AuthStatus> authStatus = AuthStatus.none.obs;
  int settlementId = 0;

  void changeStatus(AuthStatus status) {
    authStatus(status);
  }
}

enum AuthStatus {
  none,
  unAuthorized,
  verifyPhone,
  verifyEmail,
  hasSettlement;

  const AuthStatus();
}
