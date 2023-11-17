import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalsha/features/orders/presentation/widgets/filter.dart';
import 'package:khalsha/features/statistics/presentation/widgets/periods_statistic.dart';
import 'package:khalsha/features/widgets/stylish_text.dart';

import 'package:khalsha/core/data/models/enums/service_types.dart';
import 'package:khalsha/features/widgets/custom_app_bar.dart';
import 'package:khalsha/features/widgets/headline_bottom_sheet.dart';
import 'package:khalsha/features/widgets/services_filtration_sheet.dart';
import 'package:khalsha/features/statistics/presentation/get/controllers/controller.dart';

class StatisticsView extends GetView<StatisticsController> {
  const StatisticsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'إحصائياتي',
      ),
      body: Obx(() => controller.loading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              children: [
                Obx(() => Filter(
                      selectedService: ServiceTypes
                          .values[controller.selectedService.value].value,
                      onTap: () => Get.bottomSheet(
                        HeadLineBottomSheet(
                          bottomSheetTitle: 'فلترة الإحصائيات',
                          body: ServicesFiltrationSheet(
                            selectedService: controller.selectedService,
                            onDoneTapped: () {
                              Get.back();
                              controller.getStatistics();
                            },
                          ),
                          height: Get.height / 2.2,
                        ),
                      ),
                    )),
                TextUnderline(
                  'إجمالي الارباح ${controller.statisticsModel.value.totalProfit ?? 0}',
                ),
                const SizedBox(height: 14),
                PeriodsStatistic(
                  controller.statisticsModel.value,
                ),
              ],
            )),
    );
  }
}
