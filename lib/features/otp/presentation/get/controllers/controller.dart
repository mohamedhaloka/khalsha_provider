import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/features/otp/domain/use_cases/check_code_use_case.dart';
import 'package:khalsha/features/otp/domain/use_cases/send_code.dart';

import '../../../../../core/data/source/local/user_local.dart';
import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../../core/utils.dart';

const kUserData = 'userData';
const kVerifyType = 'verifyType';

class OTPController extends GetxController {
  final SendCodeUseCase _sendMobileCodeUseCase;
  final CheckCodeUseCase _checkCodeUseCase;
  OTPController(
    this._sendMobileCodeUseCase,
    this._checkCodeUseCase,
  );

  final userData = Get.arguments[kUserData];
  final verifyType = Get.arguments[kVerifyType];

  TextEditingController code = TextEditingController();

  RxInt timer = 0.obs;
  RxBool loading = false.obs;

  @override
  void onInit() async {
    resendCode();
    super.onInit();
  }

  void resendCode() {
    _resetTimer();
    _sendCode();
  }

  void _resetTimer() =>
      timer.value = DateTime.now().millisecondsSinceEpoch + 1000 * 60;

  Future<void> _sendCode() async {
    final params = SendCodeParams(loading: loading, verifyType: verifyType);
    final result = await _sendMobileCodeUseCase.execute(params);
    result.fold(
      (Failure failure) => showAlertMessage(failure.statusMessage),
      (String successMsg) => showAlertMessage(successMsg),
    );
  }

  Future<void> checkCode() async {
    final params = CheckCodeParams(
      loading: loading,
      code: code.text,
      verifyType: verifyType,
    );
    final result = await _checkCodeUseCase.execute(params);
    result.fold(
      (Failure failure) => showAlertMessage(failure.statusMessage),
      (String successMsg) {
        showAlertMessage(successMsg);
        UserDataLocal.instance.save(userData);
        Get.offAllNamed(Routes.root);
      },
    );
  }
}
