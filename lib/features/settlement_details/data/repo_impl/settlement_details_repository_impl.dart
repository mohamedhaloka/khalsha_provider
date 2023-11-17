import 'package:dartz/dartz.dart';
import 'package:khalsha/core/data/repository_impl/base_repository_impl.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/features/settlement/data/models/settlement.dart';
import 'package:khalsha/features/settlement_details/data/data_source/settlement_details_remote_data_source.dart';
import 'package:khalsha/features/settlement_details/domain/repository/settlement_details_repository.dart';

class SettlementDetailsRepositoryImpl extends BaseRepositoryImpl
    implements SettlementDetailsRepository {
  final SettlementDetailsRemoteDataSource _settlementDetailsRemoteDataSource;
  SettlementDetailsRepositoryImpl(this._settlementDetailsRemoteDataSource);

  @override
  Future<Either<Failure, String>> callbackPayment(
      int settlementId, String paymentId) async {
    return request(() async {
      final result = await _settlementDetailsRemoteDataSource.callbackPayment(
          settlementId, paymentId);
      return right(result);
    });
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
    return request(() async {
      final result = await _settlementDetailsRemoteDataSource.preparePayment(
        settlementId,
        cardNumber: cardNumber,
        cardHolderName: cardHolderName,
        cvv: cvv,
        month: month,
        year: year,
      );
      return right(result);
    });
  }

  @override
  Future<Either<Failure, SettlementModel>> getSettlementById(String id) async {
    return request(() async {
      final result =
          await _settlementDetailsRemoteDataSource.getSettlementById(id);
      return right(result);
    });
  }
}
