import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';
import 'package:khalsha/core/presentation/routes/app_routes.dart';
import 'package:khalsha/core/utils.dart';
import 'package:khalsha/features/settlement/data/models/settlement.dart';
import 'package:khalsha/features/settlement_details/domain/use_cases/callback_payment_use_case.dart';
import 'package:khalsha/features/settlement_details/domain/use_cases/get_settlement_by_id_use_case.dart';
import 'package:khalsha/features/settlement_details/domain/use_cases/prepare_payment_use_case.dart';

class SettlementDetailsController extends GetxController {
  final PreparePaymentUseCase _preparePaymentUseCase;
  final CallbackPaymentUseCase _callbackPaymentUseCase;
  final GetSettlementByIdUseCase _getSettlementByIdUseCase;
  SettlementDetailsController(
    this._preparePaymentUseCase,
    this._callbackPaymentUseCase,
    this._getSettlementByIdUseCase,
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late CreditCardModel cardData;
  SettlementModel settlementModel = Get.arguments;

  RxBool getSettlementDetailsLoading = false.obs;
  RxBool loading = false.obs;
  RxBool hasError = false.obs;

  @override
  void onInit() {
    if (settlementModel.getTotal == null) {
      getSettlementById();
    }
    super.onInit();
  }

  Future<void> getSettlementById() async {
    final params = GetSettlementByIdParams(
      loading: getSettlementDetailsLoading,
      id: settlementModel.id.toString(),
    );
    final result = await _getSettlementByIdUseCase.execute(params);

    result.fold(
      (failure) {
        final Map<String, dynamic> responseErrorData =
            json.decode(failure.statusMessage ?? '');

        showAlertMessage(responseErrorData['message']);
        hasError(true);
      },
      (data) => settlementModel = data,
    );
  }

  Future<void> preparePayment() async {
    formKey.currentState?.save();

    if (!(formKey.currentState?.validate() ?? false)) {
      showAlertMessage('جميع الحقول مطلوبة');

      return;
    }

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
        if (Navigator.canPop(Get.context!)) {
          Get.back(result: true);
        } else {
          Get.offAll(Routes.root);
        }
      },
    );
  }
}
