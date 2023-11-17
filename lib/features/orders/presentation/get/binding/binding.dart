import 'package:get/get.dart';
import 'package:khalsha/features/orders/presentation/get/controllers/controller.dart';
import 'package:khalsha/injection_container.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<OrdersController>(() => OrdersController(
          InjectionContainer.sl(),
        ));
  }
}
