import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/data/services/http_service.dart';
import '../../../../core/domain/error/exceptions.dart';

abstract class SettlementDetailsRemoteDataSource {
  Future<String> preparePayment(
    int settlementId, {
    required String cardNumber,
    required String cardHolderName,
    required String cvv,
    required String month,
    required String year,
  });
  Future<String> callbackPayment(int settlementId, String paymentId);
}

class SettlementDetailsRemoteDataSourceImpl
    extends SettlementDetailsRemoteDataSource {
  final HttpService _httpService;
  SettlementDetailsRemoteDataSourceImpl(this._httpService);

  @override
  Future<String> preparePayment(
    int settlementId, {
    required String cardNumber,
    required String cardHolderName,
    required String cvv,
    required String month,
    required String year,
  }) async {
    final formData = FormData.fromMap({
      'name': cardHolderName,
      'card_number': cardNumber,
      'cvc': cvv,
      'month': month,
      'year': year,
    });
    final response = await _httpService.post(
        '${HttpService.userType}/prepare/settlements/$settlementId', formData);

    if (response.statusCode == 201) {
      return response.data['transaction_url'];
    } else {
      throw ServerException(errorMessage: response.data.toString());
    }
  }

  @override
  Future<String> callbackPayment(int settlementId, String paymentId) async {
    final formData = FormData.fromMap({});
    final response = await _httpService.post(
        '${HttpService.userType}/callback/settlements/$settlementId?id=$paymentId',
        formData);

    log(response.data.toString());
    if (response.statusCode == 200) {
      return response.data.toString();
    } else {
      throw ServerException(errorMessage: response.data.toString());
    }
  }
}
