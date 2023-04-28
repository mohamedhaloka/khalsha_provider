import 'package:get/get.dart';
import 'package:khalsha/injection_container.dart';

import '../controllers/controller.dart';

class MyBillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyBillsController>(() => MyBillsController(
          InjectionContainer.sl(),
        ));
  }
}
