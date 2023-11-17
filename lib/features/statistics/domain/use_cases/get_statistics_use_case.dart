import 'package:dartz/dartz.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/core/domain/use_cases/use_case.dart';

import 'package:khalsha/features/statistics/data/models/statistics_model.dart';
import 'package:khalsha/features/statistics/domain/repository/statistics_repository.dart';

class GetStatisticsUseCase
    extends UseCase<StatisticsModel, GetStatisticsUseCaseParams> {
  final StatisticsRepository _statisticsRepository;
  GetStatisticsUseCase(this._statisticsRepository);

  @override
  Future<Either<Failure, StatisticsModel>> execute(
      GetStatisticsUseCaseParams params) async {
    params.loading(true);
    final call = _statisticsRepository.getStatistics(params.type);
    call.then((_) => params.loading(false));
    return call;
  }
}

class GetStatisticsUseCaseParams extends Params {
  final String type;
  GetStatisticsUseCaseParams({
    required super.loading,
    required this.type,
  });
}
