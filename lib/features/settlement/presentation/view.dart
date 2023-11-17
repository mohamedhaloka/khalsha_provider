import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalsha/core/presentation/routes/app_routes.dart';
import 'package:khalsha/core/presentation/themes/colors_manager.dart';
import 'package:khalsha/features/settlement/presentation/get/controllers/controller.dart';
import 'package:khalsha/features/widgets/smart_refresh.dart';
import 'package:khalsha/features/widgets/table_items.dart';

const kSettled = 'settled';

class SettlementView extends GetView<SettlementController> {
  const SettlementView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loading.value
        ? const Center(
            child: CircularProgressIndicator(),
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
                    if (controller.settlements[index].status == kSettled) {
                      return;
                    }
                    final result = await Get.toNamed(
                      Routes.settlementDetails,
                      arguments: controller.settlements[index],
                    );

                    if (result == null) return;
                    if (!result) return;

                    controller.onRefresh();
                  },
                  itemsHeader: const [
                    'رقم التسوية',
                    'إجمالي التسوية',
                    'الحالة',
                    ''
                  ],
                  itemBuilder: (int index) => Row(
                    children: [
                      _detail(controller.settlements[index].id.toString()),
                      _detail(
                        '${controller.settlements[index].getTotal!.total} ${'riyal_saudi'.tr}',
                      ),
                      _detail(controller.settlements[index].status!.tr),
                      if (controller.settlements[index].status != kSettled) ...[
                        _detail(
                          'تسوية',
                          textColor: ColorManager.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ] else ...[
                        const Expanded(child: SizedBox())
                      ]
                    ],
                  ),
                  itemCount: controller.settlements.length,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Text(
                    'يتم تسوية الفاتورة في حال تجاوزها مده لا تقل عن ثلاثين يوماً او في حال بلوغها الحد الإقصي وهو خمسمائة ريال.',
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
