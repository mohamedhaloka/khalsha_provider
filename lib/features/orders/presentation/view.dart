import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalsha/core/presentation/themes/colors_manager.dart';
import 'package:khalsha/features/orders/presentation/widgets/filter.dart';
import 'package:khalsha/features/orders/presentation/widgets/order_item.dart';
import 'package:khalsha/features/widgets/custom_app_bar.dart';
import 'package:khalsha/features/widgets/smart_refresh.dart';

import '../../../core/data/models/enums/service_types.dart';
import '../../widgets/headline_bottom_sheet.dart';
import '../../widgets/services_filtration_sheet.dart';
import 'get/controllers/controller.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final controller = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: controller.serviceType == null
          ? null
          : CustomAppBar(
              title: 'عروض ${controller.serviceType!.value.tr}',
            ),
      body: SmartRefresh(
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        footer: true,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Filter(
              onTap: () => Get.bottomSheet(
                HeadLineBottomSheet(
                  bottomSheetTitle: 'فلترة عروضي',
                  body: ServicesFiltrationSheet(
                    'الخدمة المقدمة',
                    selectedService: controller.selectedService,
                    onDoneTapped: () {
                      Get.back();
                      controller.onRefresh();
                    },
                  ),
                  height: Get.height / 3,
                ),
              ),
            ),
            Obx(
              () => controller.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.secondaryColor,
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, int index) => OrderItem(
                        controller.orders[index],
                        serviceType: ServiceTypes
                            .values[controller.selectedService.value],
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
