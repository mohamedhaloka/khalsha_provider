import 'package:dartz/dartz.dart';
import 'package:khalsha/core/data/repository_impl/base_repository_impl.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/features/settlement/data/data_source/settlement_remote_data_source.dart';
import 'package:khalsha/features/settlement/data/models/settlement.dart';
import 'package:khalsha/features/settlement/domain/repo/settlement_repository.dart';

class SettlementRepositoryImpl extends BaseRepositoryImpl
    implements SettlementRepository {
  final SettlementRemoteDataSource _settlementRemoteDataSource;
  SettlementRepositoryImpl(this._settlementRemoteDataSource);

  @override
  Future<Either<Failure, List<SettlementModel>>> getSettlements() async {
    return request(() async {
      final result = await _settlementRemoteDataSource.getSettlements();
      return right(result);
    });
  }
}
