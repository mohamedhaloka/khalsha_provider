import 'package:get/get.dart';
import 'package:khalsha/injection_container.dart';

import 'package:khalsha/features/settlement/presentation/get/controllers/controller.dart';

class SettlementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettlementController>(
        () => SettlementController(InjectionContainer.sl()));
  }
}
