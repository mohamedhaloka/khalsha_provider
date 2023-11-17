import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalsha/core/presentation/themes/colors_manager.dart';
import 'package:khalsha/features/order_details/data/models/invoice_item_model.dart';
import 'package:khalsha/features/order_details/presentation/view.dart';
import 'package:khalsha/features/widgets/custom_button.dart';
import 'package:khalsha/features/widgets/inputs/text_field_input_with_holder.dart';

class ItemsOfInvoiceSheet extends GetView<OrderDetailsController> {
  const ItemsOfInvoiceSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.separated(
                itemBuilder: (_, int index) => Column(
                  children: [
                    TextFieldInputWithHolder(
                      title: 'بيان الخدمة',
                      controller: controller.invoiceItems[index].service,
                    ),
                    TextFieldInputWithHolder(
                      title: 'الاجمالى',
                      controller: controller.invoiceItems[index].totals,
                      keyboardType: TextInputType.number,
                    ),
                    if (controller.invoiceItems.length > 1)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomButton(
                          width: 40,
                          height: 40,
                          onTap: () => controller.invoiceItems
                              .remove(controller.invoiceItems[index]),
                          imgName: 'delete',
                          backgroundColor: ColorManager.errorColor,
                        ),
                      ),
                  ],
                ),
                separatorBuilder: (_, __) => const Divider(),
                itemCount: controller.invoiceItems.length,
              ),
            ),
          ),
          Row(
            children: [
              const Expanded(child: Divider(color: ColorManager.greyColor)),
              InkWell(
                  onTap: () =>
                      controller.invoiceItems.add(InvoiceItemModel.newItem()),
                  child: const Chip(label: Text('أضف عنصر جديد +'))),
              const Expanded(child: Divider(color: ColorManager.greyColor)),
            ],
          ),
          CustomButton(
            onTap: Get.back,
            text: 'تأكيد',
            width: Get.width,
          ),
        ],
      ),
    );
  }
}
