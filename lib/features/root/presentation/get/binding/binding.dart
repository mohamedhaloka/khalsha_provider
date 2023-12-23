import 'package:get/get.dart';
import 'package:khalsha/features/home/presentation/get/controllers/controller.dart';
import 'package:khalsha/features/new_orders/presentation/get/controllers/controller.dart';
import 'package:khalsha/features/notifications/presentation/get/controllers/controller.dart';
import 'package:khalsha/features/profile/presentation/get/controllers/controller.dart';
import 'package:khalsha/features/root/presentation/get/controllers/controller.dart';
import 'package:khalsha/features/settlement/presentation/get/controllers/controller.dart';
import 'package:khalsha/injection_container.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(() => RootController(
          InjectionContainer.sl(),
          InjectionContainer.sl(),
          InjectionContainer.sl(),
          InjectionContainer.sl(),
        ));
    Get.lazyPut<SettlementController>(
        () => SettlementController(InjectionContainer.sl()));
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(
        () => ProfileController(InjectionContainer.sl()));
    Get.create<NotificationsController>(() => NotificationsController(
          InjectionContainer.sl(),
        ));
    // Get.create<OrdersController>(() => OrdersController(
    //   InjectionContainer.sl(),
    // ));

    Get.lazyPut<NewOrdersController>(() => NewOrdersController(
          InjectionContainer.sl(),
        ));
  }
}
