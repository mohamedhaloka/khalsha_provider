import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:khalsha/core/data/services/http_service.dart';
import 'package:khalsha/core/domain/error/exceptions.dart';
import 'package:khalsha/features/settlement/data/models/settlement.dart';

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

  Future<SettlementModel> getSettlementById(String id);
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

  @override
  Future<SettlementModel> getSettlementById(String id) async {
    final response =
        await _httpService.get('${HttpService.userType}/settlements/$id');

    if (response.statusCode == 200) {
      return SettlementModel.fromJson(response.data);
    } else {
      throw ServerException(errorMessage: jsonEncode(response.data));
    }
  }
}
