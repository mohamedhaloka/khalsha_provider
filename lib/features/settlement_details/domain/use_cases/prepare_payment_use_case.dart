import 'package:dartz/dartz.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/core/domain/use_cases/use_case.dart';
import 'package:khalsha/features/settlement_details/domain/repository/settlement_details_repository.dart';

class PreparePaymentUseCase extends UseCase<String, PreparePaymentParams> {
  final SettlementDetailsRepository _settlementDetailsRepository;
  PreparePaymentUseCase(this._settlementDetailsRepository);

  @override
  Future<Either<Failure, String>> execute(PreparePaymentParams params) async {
    params.loading(true);
    final call = _settlementDetailsRepository.preparePayment(
      params.settlementId,
      cardNumber: params.cardNumber,
      cardHolderName: params.cardHolderName,
      cvv: params.cvv,
      month: params.month,
      year: params.year,
    );
    call.then((_) => params.loading(false));
    return call;
  }
}

class PreparePaymentParams extends Params {
  final int settlementId;
  final String cardNumber;
  final String cardHolderName;
  final String cvv;
  final String month;
  final String year;

  PreparePaymentParams({
    required super.loading,
    required this.settlementId,
    required this.cardNumber,
    required this.cardHolderName,
    required this.cvv,
    required this.month,
    required this.year,
  });
}
