import 'package:dartz/dartz.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/core/domain/use_cases/use_case.dart';
import 'package:khalsha/features/settlement/data/models/settlement.dart';
import 'package:khalsha/features/settlement_details/domain/repository/settlement_details_repository.dart';

class GetSettlementByIdUseCase
    extends UseCase<SettlementModel, GetSettlementByIdParams> {
  final SettlementDetailsRepository _settlementDetailsRepository;
  GetSettlementByIdUseCase(this._settlementDetailsRepository);

  @override
  Future<Either<Failure, SettlementModel>> execute(
      GetSettlementByIdParams params) async {
    params.loading(true);
    final call = _settlementDetailsRepository.getSettlementById(
      params.id,
    );
    call.then((_) => params.loading(false));
    return call;
  }
}

class GetSettlementByIdParams extends Params {
  final String id;

  GetSettlementByIdParams({
    required super.loading,
    required this.id,
  });
}
