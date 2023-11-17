import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';
import 'package:khalsha/core/presentation/themes/colors_manager.dart';
import 'package:khalsha/features/settlement_details/presentation/get/controllers/controller.dart';
import 'package:khalsha/features/widgets/custom_app_bar.dart';
import 'package:khalsha/features/widgets/custom_button.dart';

class SettlementDetailsView extends StatefulWidget {
  const SettlementDetailsView({Key? key}) : super(key: key);

  @override
  State<SettlementDetailsView> createState() => _SettlementDetailsViewState();
}

class _SettlementDetailsViewState extends State<SettlementDetailsView> {
  final SettlementDetailsController controller =
      Get.find<SettlementDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'تسوية الطلب رقم #${controller.settlementModel.id}',
      ),
      bottomNavigationBar:
          Obx(() => controller.getSettlementDetailsLoading.value
              ? const SizedBox()
              : controller.hasError.value
                  ? const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        'حدث خطأ، أعد المحاولة لاحقاً',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorManager.errorColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 90,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            CustomButton.fillBlue(
                              text:
                                  ' دفع التسوية    ${controller.settlementModel.getTotal?.total} ${'riyal_saudi'.tr}',
                              width: Get.width,
                              loading: controller.loading,
                              onTap: controller.preparePayment,
                            ),
                          ],
                        ),
                      ),
                    )),
      body: Obx(() => controller.getSettlementDetailsLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
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
                CreditCardForm(
                  formKey: controller.formKey, // Required
                  onCreditCardModelChange: (CreditCardModel data) =>
                      controller.cardData = data, // Required
                  themeColor: Colors.red,
                  isHolderNameVisible: true,
                  isCardNumberVisible: true,
                  isExpiryDateVisible: true,
                  enableCvv: true,
                  cardNumberDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'رقم البطاقة',
                    hintText: 'XXXX XXXX XXXX XXXX',
                  ),
                  expiryDateDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'تاريخ الإنتهاء',
                    hintText: 'XX/XX',
                  ),
                  cvvCodeDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CVV',
                    hintText: 'XXX',
                  ),
                  cardHolderDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'اسم صاحب البطاقة',
                  ),
                  cardNumber: '',
                  expiryDate: '',
                  cardHolderName: '',
                  cvvCode: '',
                ),
              ],
            )),
    );
  }
}
