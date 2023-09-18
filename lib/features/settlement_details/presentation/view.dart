import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:khalsha/features/widgets/custom_button.dart';
import 'package:khalsha/features/widgets/custom_text_field.dart';

import '../../../core/card_input_formatter.dart';
import '../../../core/inputs_style.dart';
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
        height: 90,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              // CustomButton(
              //   text: 'عرض الفاتورة',
              //   width: Get.width,
              //   onTap: () => Get.toNamed(
              //     Routes.billDetails,
              //     arguments: controller.settlementModel,
              //   ),
              // ),
              // const SizedBox(height: 10),
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
            // keyboardType: TextInputType.number,
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
                  hint: 'XX/XX',
                  borderSide: inputBorderSide,
                  controller: controller.expDate,
                  // keyboardType: TextInputType.number,
                  textInputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardExpirationFormatter()
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  title: 'CVV',
                  hint: 'XXX',
                  maxLength: 3,
                  textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                  controller: controller.cvv,
                  keyboardType: TextInputType.number,
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
