import 'package:khalsha/core/data/services/http_service.dart';

import 'package:khalsha/core/domain/error/exceptions.dart';
import 'package:khalsha/features/statistics/data/models/statistics_model.dart';

abstract class StatisticsRemoteDataSource {
  Future<StatisticsModel> getStatistics(String type);
}
//statistics

class StatisticsRemoteDataSourceImpl extends StatisticsRemoteDataSource {
  final HttpService _httpService;
  StatisticsRemoteDataSourceImpl(this._httpService);

  @override
  Future<StatisticsModel> getStatistics(String type) async {
    final response =
        await _httpService.get('${HttpService.userType}/statistics?type=$type');

    if (response.statusCode == 200) {
      return StatisticsModel.fromJson(response.data['data']);
    } else {
      throw ServerException(errorMessage: response.data['message'].toString());
    }
  }
}
