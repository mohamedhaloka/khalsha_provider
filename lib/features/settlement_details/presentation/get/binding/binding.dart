import 'package:get/get.dart';

import '../../../../../injection_container.dart';
import '../controllers/controller.dart';

class SettlementDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettlementDetailsController>(() => SettlementDetailsController(
          InjectionContainer.sl(),
          InjectionContainer.sl(),
        ));
  }
}
