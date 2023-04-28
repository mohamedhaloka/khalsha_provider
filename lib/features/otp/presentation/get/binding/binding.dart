import 'package:get/get.dart';
import 'package:khalsha/injection_container.dart';

import '../controllers/controller.dart';

class OTPBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OTPController>(() => OTPController(
          InjectionContainer.sl(),
          InjectionContainer.sl(),
        ));
  }
}
