import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khalsha/core/data/models/item_model.dart';
import 'package:khalsha/core/data/services/http_service.dart';
import 'package:khalsha/core/domain/use_cases/upload_image_use_case.dart';
import 'package:khalsha/core/presentation/extentions/format_datetime_extention.dart';
import 'package:khalsha/features/order_details/data/models/invoice_data.dart';
import 'package:khalsha/features/order_details/data/models/order_details_item_model.dart';
import 'package:khalsha/features/order_details/domain/use_cases/add_offer_use_case.dart';
import 'package:khalsha/features/order_details/domain/use_cases/create_invoice_use_case.dart';
import 'package:khalsha/features/order_details/domain/use_cases/get_order_details_use_case.dart';
import 'package:khalsha/features/order_details/domain/use_cases/update_order_status_use_case.dart';
import 'package:khalsha/features/order_details/presentation/widgets/create_bill.dart';
import 'package:khalsha/features/order_details/presentation/widgets/invoice_details_view.dart';
import 'package:khalsha/features/order_details/presentation/widgets/order_tab_header.dart';
import 'package:khalsha/features/order_details/presentation/widgets/status_steps.dart';
import 'package:khalsha/features/widgets/custom_button.dart';
import 'package:khalsha/features/widgets/headline_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/domain/use_cases/delete_file_use_case.dart';
import '../../../../../core/utils.dart' as util;
import '../../../core/data/models/enums/service_types.dart';
import '../../../core/presentation/themes/colors_manager.dart';
import '../../orders/domain/entities/order_model.dart';
import '../../widgets/bill.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/stylish_text.dart';
import '../data/models/invoice_item_model.dart';
import '../data/models/offer_input_item.dart';
import 'bottom_sheets/add_pricing_offer.dart';

part 'get/controllers/controller.dart';
part 'tabs/bill_data.dart';
part 'tabs/order_data.dart';
part 'tabs/status_data.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() => controller.loading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: Get.theme.primaryColor,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const _DetailsTabs(),
                  Expanded(
                    child: PageView(
                      controller: controller.pageViewController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (int index) =>
                          controller.currentTab(index),
                      children: controller.pages.map((e) => e.child!).toList(),
                    ),
                  ),
                ],
              )),
      ),
    );
  }
}

class _DetailsTabs extends GetView<OrderDetailsController> {
  const _DetailsTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: controller.pages
              .map(
                (e) => _tabWidget(
                  id: e.id!,
                  imgName: e.image!,
                ),
              )
              .toList(),
        ));
  }

  Widget _tabWidget({
    required int id,
    required String imgName,
  }) {
    int index = controller.pages.indexWhere((element) => element.id == id);
    return Expanded(
      child: Row(
        children: [
          _separator,
          InkWell(
            onTap: () => controller.goToParticularPage(index),
            child: CircleAvatar(
              radius: controller.currentTab.value == index ? 22 : 18,
              backgroundColor: controller.currentTab.value == index
                  ? ColorManager.primaryColor
                  : ColorManager.lightGreyColor,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  'assets/images/order_details/$imgName.svg',
                  color: controller.currentTab.value == index
                      ? Colors.white
                      : ColorManager.greyColor,
                ),
              ),
            ),
          ),
          _separator,
        ],
      ),
    );
  }

  Widget get _separator => Expanded(
        child: Container(
          height: 1,
          color: ColorManager.lightGreyColor,
        ),
      );
}
