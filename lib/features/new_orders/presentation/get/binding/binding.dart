import 'package:get/get.dart';
import 'package:khalsha/injection_container.dart';

import 'package:khalsha/features/new_orders/presentation/get/controllers/controller.dart';

class NewOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewOrdersController>(() => NewOrdersController(
          InjectionContainer.sl(),
        ));
  }
}
