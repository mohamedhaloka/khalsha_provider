import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalsha/core/data/models/enums/service_types.dart';
import 'package:khalsha/features/orders/presentation/get/controllers/controller.dart';
import 'package:khalsha/features/orders/presentation/widgets/order_item.dart';
import 'package:khalsha/features/widgets/custom_app_bar.dart';
import 'package:khalsha/features/widgets/smart_refresh.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final controller = Get.find<OrdersController>();

  // Timer? timer;

  // Intro intro = Intro(
  //   noAnimation: false,
  //   stepCount: 1,
  //   borderRadius: const BorderRadius.all(Radius.circular(4)),
  //   widgetBuilder: StepWidgetBuilder.useDefaultTheme(
  //     texts: ['يمكنك استعراض عروضك من خلال الضغط هنا.'],
  //     buttonTextBuilder: (curr, total) => 'حسناً',
  //   ),
  // );

  // @override
  // void initState() {
  //   final Map<String, dynamic> introMap = IntroHintCountLocal.instance.get();
  //   String nameKey = 'offers';
  //   if ((introMap[nameKey] ?? 0) > 3) return;
  //   timer = Timer(
  //     const Duration(seconds: 1),
  //     () {
  //       intro.start(context);
  //       IntroHintCountLocal.instance.save(nameKey);
  //     },
  //   );
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: controller.serviceType == null
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Obx(() => CustomAppBar(
                    title:
                        'عروض ${ServiceTypes.values[controller.selectedService.value].value.tr}',
                  )),
            ),
      body: SmartRefresh(
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        footer: true,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Obx(() => Filter(
            //       key: intro.keys[0],
            //       selectedService: ServiceTypes
            //           .values[controller.selectedService.value].value,
            //       onTap: () => Get.bottomSheet(
            //         HeadLineBottomSheet(
            //           bottomSheetTitle: 'اختر الخدمة',
            //           body: ServicesFiltrationSheet(
            //             selectedService: controller.selectedService,
            //             onDoneTapped: () {
            //               Get.back();
            //               controller.onRefresh();
            //             },
            //           ),
            //           height: Get.height / 3,
            //         ),
            //       ),
            //     )),
            Obx(
              () => controller.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, int index) => OrderItem(
                        controller.orders[index],
                        serviceType: ServiceTypes
                            .values[controller.selectedService.value],
                        onRefresh: controller.onRefresh,
                      ),
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                      itemCount: controller.orders.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
