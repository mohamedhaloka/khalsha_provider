import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:khalsha/features/widgets/custom_button.dart';
import 'package:khalsha/features/widgets/custom_text_field.dart';

import '../../../core/card_input_formatter.dart';
import '../../../core/inputs_style.dart';
import '../../../core/presentation/routes/app_routes.dart';
import '../../../core/presentation/themes/colors_manager.dart';
import '../../widgets/custom_app_bar.dart';
import 'get/controllers/controller.dart';

class SettlementDetailsView extends GetView<SettlementDetailsController> {
  const SettlementDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'تسوية الطلب رقم #${controller.settlementModel.id}',
      ),
      bottomNavigationBar: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              CustomButton(
                text: 'عرض الفاتورة',
                width: Get.width,
                onTap: () => Get.toNamed(
                  Routes.billDetails,
                  arguments: controller.settlementModel,
                ),
              ),
              const SizedBox(height: 10),
              CustomButton.fillBlue(
                text: 'دفع التسوية',
                width: Get.width,
                loading: controller.loading,
                onTap: controller.preparePayment,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'ادخل بيانات بطاقتك',
              style: Get.textTheme.titleLarge!.copyWith(
                color: ColorManager.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomTextField(
            title: 'رقم البطاقة',
            borderSide: inputBorderSide,
            hint: 'XXXX XXXX XXXX XXXX',
            controller: controller.cardNumber,
            textInputFormatter: [
              FilteringTextInputFormatter.digitsOnly,
              CardNumberFormatter(),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  title: 'تاريخ الإنتهاء',
                  borderSide: inputBorderSide,
                  controller: controller.expDate,
                  maxLength: 5,
                  onChanged: (String value) {
                    if (value.length == 2) {
                      if (controller.expDate.text.contains("/")) {
                        controller.expDate.text += value;
                        return;
                      }
                      controller.expDate.text += "/";
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  title: 'CVV',
                  maxLength: 3,
                  controller: controller.cvv,
                  borderSide: inputBorderSide,
                ),
              ),
            ],
          ),
          CustomTextField(
            title: 'اسم صاحب البطاقة',
            controller: controller.cardHolderName,
            borderSide: inputBorderSide,
          ),
          // CustomDropDown(
          //   title: 'عنوان وصول الفواتير',
          //   dropVal: ''.obs,
          //   source: [].obs,
          //   isExpanded: true,
          //   radius: 10,
          // )
        ],
      ),
    );
  }
}
