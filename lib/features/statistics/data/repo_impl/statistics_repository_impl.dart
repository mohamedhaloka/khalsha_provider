import 'package:dartz/dartz.dart';
import 'package:khalsha/core/data/repository_impl/base_repository_impl.dart';
import 'package:khalsha/core/domain/error/failures.dart';
import 'package:khalsha/features/statistics/data/data_source/statistics_remote_data_source.dart';
import 'package:khalsha/features/statistics/data/models/statistics_model.dart';
import 'package:khalsha/features/statistics/domain/repository/statistics_repository.dart';

class StatisticsRepositoryImpl extends BaseRepositoryImpl
    implements StatisticsRepository {
  final StatisticsRemoteDataSource _statisticsRemoteDataSource;
  StatisticsRepositoryImpl(this._statisticsRemoteDataSource);

  @override
  Future<Either<Failure, StatisticsModel>> getStatistics(String type) async {
    return request(() async {
      final result = await _statisticsRemoteDataSource.getStatistics(type);
      return right(result);
    });
  }
}
