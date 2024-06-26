import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalsha/features/orders/presentation/widgets/filter.dart';
import 'package:khalsha/features/widgets/headline_bottom_sheet.dart';
import 'package:khalsha/features/widgets/services_filtration_sheet.dart';
import 'package:khalsha/features/widgets/smart_refresh.dart';

import '../../../core/data/models/enums/service_types.dart';
import '../../../core/presentation/routes/app_routes.dart';
import '../../../core/presentation/themes/colors_manager.dart';
import '../../order_details/presentation/view.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/table_items.dart';
import 'get/controllers/controller.dart';

class NewOrdersView extends GetView<NewOrdersController> {
  const NewOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'الطلبات الجديدة',
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
                  bottomSheetTitle: 'الطلبات الجديدة',
                  body: ServicesFiltrationSheet(
                    'طلبات خدمة',
                    selectedService: controller.selectedService,
                    onDoneTapped: () {
                      Get.back();
                      controller.onRefresh();
                    },
                  ),
                  height: Get.height / 2.5,
                ),
              ),
            ),
            Obx(
              () => controller.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : TableItems(
                      onItemTapped: (int index) async {
                        final result = await Get.toNamed(
                          Routes.orderDetails,
                          arguments: {
                            orderIdKey: controller.orders[index].id,
                            serviceTypeKey: ServiceTypes
                                .values[controller.selectedService.value],
                            offerStatusKey: controller.orders[index].status,
                          },
                        );
                        if (result == null) return;

                        if (result is bool && result) {
                          controller.onRefresh();
                        }
                      },
                      itemsHeader: const [
                        'اسم الطلب',
                        'اسم المستخدم',
                        'الحالة',
                        ''
                      ],
                      itemBuilder: (int index) => Row(
                        children: [
                          _detail(controller.orders[index].title.toString()),
                          _detail(
                              controller.orders[index].user.name.toString()),
                          _detail(controller.orders[index].status),
                          _detail(
                            'رؤية التفاصيل',
                            textColor: ColorManager.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      itemCount: controller.orders.length,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Text(
                'يتم تسوية الفاتورة في حال تجاوزها مده لا تقل عن ثلاثين يوماً او في حال بلوغها الحد الإقصي وهو مائة ريال.',
                style: Get.textTheme.bodyMedium!.copyWith(
                  color: ColorManager.darkTobyColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _detail(String text, {Color? textColor, FontWeight? fontWeight}) =>
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Get.textTheme.labelLarge!.copyWith(
              color: textColor,
              fontWeight: fontWeight,
            ),
          ),
        ),
      );
}
