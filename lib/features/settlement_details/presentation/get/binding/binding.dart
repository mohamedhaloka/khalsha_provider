import 'package:get/get.dart';
import 'package:khalsha/features/settlement_details/presentation/get/controllers/controller.dart';
import 'package:khalsha/injection_container.dart';

class SettlementDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettlementDetailsController>(() => SettlementDetailsController(
          InjectionContainer.sl(),
          InjectionContainer.sl(),
          InjectionContainer.sl(),
        ));
  }
}
