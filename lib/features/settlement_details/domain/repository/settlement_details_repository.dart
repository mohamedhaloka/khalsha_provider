import 'package:dartz/dartz.dart';

import '../../../../core/domain/error/failures.dart';

abstract class SettlementDetailsRepository {
  Future<Either<Failure, String>> preparePayment(
    int settlementId, {
    required String cardNumber,
    required String cardHolderName,
    required String cvv,
    required String month,
    required String year,
  });

  Future<Either<Failure, String>> callbackPayment(
    int settlementId,
    String paymentId,
  );
}
