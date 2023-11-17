import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:khalsha/features/orders/presentation/widgets/filter.dart';
import 'package:khalsha/features/widgets/headline_bottom_sheet.dart';
import 'package:khalsha/features/widgets/services_filtration_sheet.dart';
import 'package:khalsha/features/widgets/smart_refresh.dart';

import 'package:khalsha/core/data/models/enums/service_types.dart';
import 'package:khalsha/core/data/source/local/intro_hint_count_locale.dart';
import 'package:khalsha/core/presentation/routes/app_routes.dart';
import 'package:khalsha/core/presentation/themes/colors_manager.dart';
import 'package:khalsha/features/order_details/presentation/view.dart';
import 'package:khalsha/features/widgets/custom_app_bar.dart';
import 'package:khalsha/features/widgets/table_items.dart';
import 'package:khalsha/features/new_orders/presentation/get/controllers/controller.dart';

class NewOrdersView extends StatefulWidget {
  const NewOrdersView({Key? key}) : super(key: key);

  @override
  State<NewOrdersView> createState() => _NewOrdersViewState();
}

class _NewOrdersViewState extends State<NewOrdersView> {
  final controller = Get.find<NewOrdersController>();

  Timer? timer;

  Intro intro = Intro(
    noAnimation: false,
    stepCount: 1,
    borderRadius: const BorderRadius.all(Radius.circular(4)),
    widgetBuilder: StepWidgetBuilder.useDefaultTheme(
      texts: ['يمكنك استعراض طلبات العملاء من خلال الضغط هنا.'],
      buttonTextBuilder: (curr, total) => 'حسناً',
    ),
  );

  @override
  void initState() {
    final Map<String, dynamic> introMap = IntroHintCountLocal.instance.get();
    String nameKey = 'new_orders';
    if ((introMap[nameKey] ?? 0) >= 3) return;
    timer = Timer(
      const Duration(seconds: 1),
      () {
        intro.start(context);
        IntroHintCountLocal.instance.save(nameKey);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

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
            Obx(() => Filter(
                  key: intro.keys[0],
                  selectedService: ServiceTypes
                      .values[controller.selectedService.value].value,
                  onTap: () => Get.bottomSheet(
                    HeadLineBottomSheet(
                      bottomSheetTitle: 'الطلبات الجديدة',
                      body: ServicesFiltrationSheet(
                        selectedService: controller.selectedService,
                        onDoneTapped: () {
                          Get.back();
                          controller.onRefresh();
                        },
                      ),
                      height: Get.height / 2.5,
                    ),
                  ),
                )),
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
                          _detail((controller.orders[index].user?.name ?? '')
                              .toString()),
                          _detail(controller.orders[index].status.tr),
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
