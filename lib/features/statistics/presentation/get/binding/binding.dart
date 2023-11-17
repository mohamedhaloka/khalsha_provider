import 'package:get/get.dart';
import 'package:khalsha/injection_container.dart';

import 'package:khalsha/features/statistics/presentation/get/controllers/controller.dart';

class StatisticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatisticsController>(
        () => StatisticsController(InjectionContainer.sl()));
  }
}
