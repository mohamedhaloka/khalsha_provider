import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalsha/core/data/models/data_model.dart';
import 'package:khalsha/core/inputs_style.dart';
import 'package:khalsha/core/presentation/themes/colors_manager.dart';
import 'package:khalsha/features/widgets/bottom_sheet_content/dismantling_and_installation_service.dart';
import 'package:khalsha/features/widgets/counter_component.dart';
import 'package:khalsha/features/widgets/inputs/input_holder_box.dart';
import 'package:khalsha/features/widgets/inputs/text_field_input_with_holder.dart';

import '../../../service_intro/presentation/get/controllers/controller.dart';
import '../../../widgets/bottom_sheet_content/add_location_sheet.dart';
import '../../../widgets/bottom_sheet_content/choose_date_time_sheet.dart';
import '../../../widgets/bottom_sheet_content/multi_items_list.dart';
import '../../../widgets/bottom_sheet_content/order_temperature.dart';
import '../../../widgets/bottom_sheet_content/set_number_count.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/inputs/attach_file_with_holder.dart';
import '../../../widgets/inputs/choose_item_with_holder.dart';
import '../../../widgets/inputs/service_item_with_holder.dart';
import '../../../widgets/inputs/yes_or_no_with_holder.dart';
import '../../../widgets/service_content.dart';
import '../../../widgets/steps/additional_service_step_view.dart';
import '../../../widgets/steps/confirm_order_step_view.dart';
import '../../../widgets/steps/fill_data_step_view.dart';
import '../../../widgets/steps/order_send_successfully_step_view.dart';
import '../../../widgets/steps/pick_locations_step_view.dart';
import 'get/controllers/controller.dart';

class CommercialDomesticLandShippingServiceView
    extends GetView<CommercialDomesticLandShippingServiceController> {
  const CommercialDomesticLandShippingServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ServiceContent(
        onTapBack: controller.onTapBack,
        onPageChanged: controller.onPageChanged,
        pageViewController: controller.pageController,
        pageTitle: controller.pageTitle,
        onTapNext: controller.onTapNext,
        currentStep: controller.currentIndex,
        btnLoading: false.obs,
        children: const [
          _FillData(),
          _AdditionalServices(),
          _PickLocations(),
          ConfirmOrderStepView(),
          OrderSendSuccessfullyStepView(),
        ],
      ),
    );
  }
}

class _FillData
    extends GetView<CommercialDomesticLandShippingServiceController> {
  const _FillData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FillDataStepView(
      serviceName:
          '${ServiceTypes.landShipping.value.tr} / ${'commercial-domestic'.tr}',
      body: Column(
        children: [
          Obx(
            () => ListView.separated(
              itemBuilder: (_, int index) => Column(
                children: [
                  if (controller.items.length > 1) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomButton(
                        width: 40,
                        height: 40,
                        onTap: () =>
                            controller.items.remove(controller.items[index]),
                        imgName: 'delete',
                        backgroundColor: ColorManager.errorColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                  const SizedBox(height: 10),
                  ChooseItemWithHolder(
                    title: 'نوع البضاعة',
                    selectedItem: DataModel.empty().obs,
                    bottomSheetTitle: 'نوع البضاعة',
                    height: Get.height / 2,
                    body: MultiItemsList(
                      items: const [],
                      selectedItem: DataModel.empty().obs,
                    ),
                  ),
                  const TextFieldInputWithHolder(
                    title: 'وصف الشحنة',
                    hint: 'مثال: نقل عفش منزلي',
                  ),
                  ChooseItemWithHolder(
                    title: 'نوع الشاحنة',
                    selectedItem: DataModel.empty().obs,
                    height: Get.height / 2,
                    body: MultiItemsList(
                      items: const [],
                      selectedItem: DataModel.empty().obs,
                    ),
                  ),
                  AttachFileWithHolder(
                    title: 'صورة البضاعة',
                    file: File('').obs,
                  ),
                  InputHolderBox(CounterComponent(
                    number: 0.obs,
                    title: 'عدد الردور المطلوبة',
                  ))
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
              separatorBuilder: (_, __) => const Divider(
                indent: 15,
                endIndent: 15,
              ),
              itemCount: controller.items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () => controller.items.add(1),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(radius)),
                  border: Border.all(color: ColorManager.greyColor),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: const Text('إضافة صنف أخر'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _AdditionalServices
    extends GetView<CommercialDomesticLandShippingServiceController> {
  const _AdditionalServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdditionalServiceStepView(
      body: Column(
        children: [
          ServiceItemWithHolder(
            title: 'خدمات الفك و التركيب و التغليف',
            height: Get.height / 1.5,
            onDelete: () {},
            body: const DismantlingAndInstallationService(),
          ),
          ServiceItemWithHolder(
            title: 'درجة حرارة الشحنة',
            bottomSheetTitle: 'درجة الحرارة',
            height: Get.height / 2,
            onDelete: () {},
            body: const OrderTemperature(),
          ),
          ServiceItemWithHolder(
            title: 'هل تحتاج عمال تحميل',
            bottomSheetTitle: 'عمال تحميل',
            height: Get.height / 3,
            onDelete: () {},
            body: SetNumberCount(
              number: 0.obs,
              title: 'عدد العمال',
            ),
          ),
          ServiceItemWithHolder(
            title: 'هل تحتاج عمال تنزيل',
            bottomSheetTitle: 'عمال تنزيل',
            height: Get.height / 3,
            onDelete: () {},
            body: SetNumberCount(
              number: 0.obs,
              title: 'عدد العمال',
            ),
          ),
          ServiceItemWithHolder(
            title: 'هل تريد التخزين',
            bottomSheetTitle: 'خدمة التخزين',
            height: Get.height / 3,
            onDelete: () {},
            body: SetNumberCount(
              number: 0.obs,
              title: 'عدد أيام التخزين',
            ),
          ),
          YesOrNoWithHolder(
            active: true.obs,
            title: 'هل توجد مواد قابلة للإشتعال',
          ),
        ],
      ),
    );
  }
}

class _PickLocations
    extends GetView<CommercialDomesticLandShippingServiceController> {
  const _PickLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PickLocationsStepView(
      children: [
        ServiceItemWithHolder(
          title: 'موقع التحميل',
          height: Get.height / 1.8,
          onDelete: () {},
          body: AddLocationSheet(
            items: <int>[1].obs,
          ),
        ),
        ServiceItemWithHolder(
          title: 'موقع التسليم',
          height: Get.height / 1.8,
          onDelete: () {},
          body: AddLocationSheet(
            items: <int>[1].obs,
            allowMulti: true,
          ),
        ),
        ServiceItemWithHolder(
          title: 'تاريخ/وقت التحميل',
          height: Get.height / 1.8,
          onDelete: () {},
          body: const ChooseDateTimeSheet(),
        ),
      ],
    );
  }
}
