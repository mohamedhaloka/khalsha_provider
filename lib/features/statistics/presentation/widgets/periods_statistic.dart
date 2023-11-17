import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalsha/features/statistics/presentation/get/controllers/controller.dart';

import 'package:khalsha/core/inputs_style.dart';
import 'package:khalsha/core/presentation/themes/colors_manager.dart';
import 'package:khalsha/features/statistics/data/models/statistics_model.dart';

class PeriodsStatistic extends GetView<StatisticsController> {
  const PeriodsStatistic(this.statistics, {Key? key}) : super(key: key);
  final StatisticsModel statistics;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStatisticItems(
          titleOne: 'أرباح اليوم',
          titleTwo: 'أرباح الشهر',
          valueOne: statistics.totalProfitToday ?? '0',
          valueTwo: statistics.totalProfitMonth ?? '0',
        ),
        _buildStatisticItems(
          titleOne: 'أرباح الاسبوع',
          titleTwo: 'أرباح السنه',
          valueOne: statistics.totalProfitWeek ?? '0',
          valueTwo: statistics.totalProfitYear ?? '0',
        ),
      ],
    );
  }

  Container _buildStatisticItems({
    required String titleOne,
    required String valueOne,
    required String titleTwo,
    required String valueTwo,
  }) =>
      Container(
        height: 82,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
                child: _buildStatisticItem(
              title: titleOne,
              value: valueOne,
            )),
            Expanded(
                child: _buildStatisticItem(
              title: titleTwo,
              value: valueTwo,
            )),
          ],
        ),
      );

  Widget _buildStatisticItem({
    required String title,
    required String value,
  }) =>
      Row(
        children: [
          Container(
            height: 60,
            width: 1,
            color: ColorManager.lightGreyColor,
            margin: const EdgeInsets.only(right: 5, left: 20),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$value ريال',
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: Get.textTheme.bodySmall!.copyWith(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ],
          )),
        ],
      );
}
