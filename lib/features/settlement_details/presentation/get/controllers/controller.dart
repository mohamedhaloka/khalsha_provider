import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khalsha/features/settlement/data/models/settlement.dart';
import 'package:khalsha/features/settlement_details/domain/use_cases/callback_payment_use_case.dart';

import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../../core/utils.dart';
import '../../../domain/use_cases/prepare_payment_use_case.dart';

class SettlementDetailsController extends GetxController {
  final PreparePaymentUseCase _preparePaymentUseCase;
  final CallbackPaymentUseCase _callbackPaymentUseCase;
  SettlementDetailsController(
    this._preparePaymentUseCase,
    this._callbackPaymentUseCase,
  );

  SettlementModel settlementModel = Get.arguments;

  RxBool loading = false.obs;

  TextEditingController cardNumber = TextEditingController(),
      expDate = TextEditingController(),
      cvv = TextEditingController(),
      cardHolderName = TextEditingController();

  Future<void> preparePayment() async {
    final params = PreparePaymentParams(
      loading: loading,
      settlementId: 3,
      cardNumber: '4111111111111111',
      cardHolderName: 'Mahmoud Ibrahim',
      cvv: '123',
      month: '12',
      year: '24',
    );

    final result = await _preparePaymentUseCase.execute(params);

    result.fold(
      (failure) => showAlertMessage(failure.statusMessage),
      (transactionUrl) async {
        final paymentId = await Get.toNamed(
          Routes.payment,
          arguments: transactionUrl,
        );

        if (paymentId == null) return;

        _callbackPayment(paymentId);
      },
    );
  }

  Future<void> _callbackPayment(String paymentId) async {
    final params = CallbackPaymentParams(
      loading: loading,
      settlementId: settlementModel.id,
      paymentId: paymentId,
    );

    final result = await _callbackPaymentUseCase.execute(params);

    result.fold(
      (failure) => showAlertMessage(failure.statusMessage),
      (data) {
        showAlertMessage(data);
        Get.back(result: true);
      },
    );
  }
}
