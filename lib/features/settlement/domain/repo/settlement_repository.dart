import 'package:dartz/dartz.dart';
import 'package:khalsha/core/domain/error/failures.dart';

import 'package:khalsha/features/settlement/data/models/settlement.dart';

abstract class SettlementRepository {
  Future<Either<Failure, List<SettlementModel>>> getSettlements();
}
