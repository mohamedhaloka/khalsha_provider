import 'package:dartz/dartz.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/core/domain/use_cases/use_case.dart';
import 'package:khalsha/features/settlement_details/domain/repository/settlement_details_repository.dart';

class CallbackPaymentUseCase extends UseCase<String, CallbackPaymentParams> {
  final SettlementDetailsRepository _settlementDetailsRepository;
  CallbackPaymentUseCase(this._settlementDetailsRepository);

  @override
  Future<Either<Failure, String>> execute(CallbackPaymentParams params) async {
    params.loading(true);
    final call = _settlementDetailsRepository.callbackPayment(
      params.settlementId,
      params.paymentId,
    );
    call.then((_) => params.loading(false));
    return call;
  }
}

class CallbackPaymentParams extends Params {
  final int settlementId;
  final String paymentId;

  CallbackPaymentParams({
    required super.loading,
    required this.settlementId,
    required this.paymentId,
  });
}
