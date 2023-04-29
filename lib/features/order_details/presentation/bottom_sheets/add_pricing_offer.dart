import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalsha/core/utils.dart';
import 'package:khalsha/features/order_details/data/models/offer_input_item.dart';
import 'package:khalsha/features/order_details/presentation/view.dart';
import 'package:khalsha/features/widgets/custom_button.dart';
import 'package:khalsha/features/widgets/custom_text_field.dart';

class AddPricingOfferSheet extends StatefulWidget {
  const AddPricingOfferSheet(this.inputs, {Key? key}) : super(key: key);
  final List<OrderInputItemModel> inputs;

  @override
  State<AddPricingOfferSheet> createState() => _AddPricingOfferSheetState();
}

class _AddPricingOfferSheetState extends State<AddPricingOfferSheet> {
  final controller = Get.find<OrderDetailsController>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: widget.inputs
                  .map(
                    (e) => CustomTextField.withBorder(
                      title: e.title,
                      controller: e.controller,
                      keyboardType: e.textInputType,
                    ),
                  )
                  .toList(),
            ),
          ),
          CustomButton(
            width: Get.width,
            loading: loading.obs,
            onTap: () async {
              bool hasEmptyInputs = false;
              for (var element in widget.inputs) {
                if (element.controller.text.isEmpty) {
                  hasEmptyInputs = true;
                  break;
                }
              }

              if (hasEmptyInputs) {
                showAlertMessage('all-fields-required');
                return;
              }
              loading = true;
              setState(() {});
              await controller.addOffer(widget.inputs);
              loading = false;
              setState(() {});
            },
            text: 'تأكيد',
          )
        ],
      ),
    );
  }
}
