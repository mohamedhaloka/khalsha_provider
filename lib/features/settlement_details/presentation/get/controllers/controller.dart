import 'package:flutter/cupertino.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late CreditCardModel cardData;
  SettlementModel settlementModel = Get.arguments;

  RxBool loading = false.obs;

  Future<void> preparePayment() async {
    formKey.currentState?.save();

    if (!(formKey.currentState?.validate() ?? false)) {
      showAlertMessage('جميع الحقول مطلوبة');

      return;
    }

    print(cardData.cardNumber.removeAllWhitespace);
    print(cardData.expiryDate.substring(0, 2));
    print(cardData.expiryDate.substring(3, 5));

    final params = PreparePaymentParams(
      loading: loading,
      settlementId: settlementModel.id,
      cardNumber: cardData.cardNumber.removeAllWhitespace,
      cardHolderName: cardData.cardHolderName,
      cvv: cardData.cvvCode,
      month: cardData.expiryDate.substring(0, 2),
      year: cardData.expiryDate.substring(3, 5),
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
