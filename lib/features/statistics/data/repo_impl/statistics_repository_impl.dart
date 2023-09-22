import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khalsha/core/presentation/extentions/response_extension.dart';
import 'package:khalsha/features/statistics/data/data_source/statistics_remote_data_source.dart';

import '../../../../core/domain/error/exceptions.dart';
import '../../../../core/domain/error/failures.dart';
import '../../domain/repository/statistics_repository.dart';
import '../models/statistics_model.dart';

class StatisticsRepositoryImpl extends StatisticsRepository {
  final StatisticsRemoteDataSource _statisticsRemoteDataSource;
  StatisticsRepositoryImpl(this._statisticsRemoteDataSource);

  @override
  Future<Either<Failure, StatisticsModel>> getStatistics(String type) async {
    try {
      final result = await _statisticsRemoteDataSource.getStatistics(type);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(statusMessage: e.errorMessage));
    } on DioError catch (e) {
      return left(ServerFailure(statusMessage: e.response!.getErrorMessage()));
    }
  }
}
