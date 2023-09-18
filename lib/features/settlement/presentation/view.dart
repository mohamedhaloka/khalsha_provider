import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalsha/features/widgets/smart_refresh.dart';
import 'package:khalsha/features/widgets/table_items.dart';

import '../../../core/presentation/routes/app_routes.dart';
import '../../../core/presentation/themes/colors_manager.dart';
import 'get/controllers/controller.dart';

class SettlementView extends GetView<SettlementController> {
  const SettlementView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loading.value
        ? const Center(
            child: CircularProgressIndicator(
              color: ColorManager.secondaryColor,
            ),
          )
        : SmartRefresh(
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            footer: false,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                TableItems(
                  onItemTapped: (int index) async {
                    final result = await Get.toNamed(
                      Routes.settlementDetails,
                      arguments: controller.settlements[index],
                    );

                    if (result == null) return;
                    if (!result) return;

                    controller.onRefresh();
                  },
                  itemsHeader: const [
                    'رقم الفاتورة',
                    'إجمالي الفاتورة',
                    'الحالة',
                    ''
                  ],
                  itemBuilder: (int index) => Row(
                    children: [
                      _detail(controller.settlements[index].id.toString()),
                      _detail(controller.settlements[index].getTotal!.total
                          .toString()),
                      _detail(controller.settlements[index].status!),
                      _detail(
                        'تسوية',
                        textColor: ColorManager.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  itemCount: controller.settlements.length,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Text(
                    'يتم تسوية الفاتورة في حال تجاوزها مده لا تقل عن ثلاثين يوماً او في حال بلوغها الحد الإقصي وهو مائة ريال.',
                    style: Get.textTheme.bodyMedium!.copyWith(
                      color: ColorManager.darkTobyColor,
                    ),
                  ),
                )
              ],
            ),
          ));
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
