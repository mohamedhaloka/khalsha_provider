import 'package:get/get.dart';
import 'package:khalsha/core/data/models/enums/service_types.dart';

import '../../../../../core/utils.dart';
import '../../../data/models/statistics_model.dart';
import '../../../domain/use_cases/get_statistics_use_case.dart';

class StatisticsController extends GetxController {
  final GetStatisticsUseCase _getStatisticsUseCase;
  StatisticsController(this._getStatisticsUseCase);

  RxInt selectedService = 0.obs;

  Rx<StatisticsModel> statisticsModel = StatisticsModel().obs;

  RxBool loading = true.obs;
  @override
  void onInit() {
    getStatistics();
    super.onInit();
  }

  Future<void> getStatistics() async {
    final params = GetStatisticsUseCaseParams(
      loading: loading,
      type: ServiceTypes.values[selectedService.value].value,
    );
    final result = await _getStatisticsUseCase.execute(params);
    result.fold(
      (failure) => showAlertMessage(failure.statusMessage),
      (data) => statisticsModel(data),
    );
  }
}
