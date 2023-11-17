import 'package:dartz/dartz.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/features/settlement/data/models/settlement.dart';

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

  Future<Either<Failure, SettlementModel>> getSettlementById(String id);
}
