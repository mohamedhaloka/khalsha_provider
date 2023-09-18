import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/core/presentation/extentions/response_extension.dart';

import '../../../../core/domain/error/exceptions.dart';
import '../../domain/repository/settlement_details_repository.dart';
import '../data_source/settlement_details_remote_data_source.dart';

class SettlementDetailsRepositoryImpl extends SettlementDetailsRepository {
  final SettlementDetailsRemoteDataSource _settlementDetailsRemoteDataSource;
  SettlementDetailsRepositoryImpl(this._settlementDetailsRemoteDataSource);

  @override
  Future<Either<Failure, String>> callbackPayment(
      int settlementId, String paymentId) async {
    try {
      final result = await _settlementDetailsRemoteDataSource.callbackPayment(
          settlementId, paymentId);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(statusMessage: e.errorMessage));
    } on DioError catch (e) {
      return left(ServerFailure(statusMessage: e.response!.getErrorMessage()));
    }
  }

  @override
  Future<Either<Failure, String>> preparePayment(
    int settlementId, {
    required String cardNumber,
    required String cardHolderName,
    required String cvv,
    required String month,
    required String year,
  }) async {
    try {
      final result = await _settlementDetailsRemoteDataSource.preparePayment(
        settlementId,
        cardNumber: cardNumber,
        cardHolderName: cardHolderName,
        cvv: cvv,
        month: month,
        year: year,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(statusMessage: e.errorMessage));
    } on DioError catch (e) {
      return left(ServerFailure(statusMessage: e.response!.getErrorMessage()));
    }
  }
}
