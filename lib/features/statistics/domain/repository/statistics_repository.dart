import 'package:dartz/dartz.dart';
import 'package:khalsha/core/domain/error/failures.dart';

import 'package:khalsha/features/statistics/data/models/statistics_model.dart';

abstract class StatisticsRepository {
  Future<Either<Failure, StatisticsModel>> getStatistics(String type);
}
