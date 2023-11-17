import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalsha/features/widgets/custom_button.dart';
import 'package:khalsha/features/widgets/custom_text_field.dart';

import 'package:khalsha/core/presentation/themes/colors_manager.dart';
import 'package:khalsha/core/inputs_style.dart';
import 'package:khalsha/features/widgets/inputs/input_holder_box.dart';

class CheckerWithHolder extends StatefulWidget {
  const CheckerWithHolder({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String? title;
  final void Function(bool) onTap;

  @override
  State<CheckerWithHolder> createState() => _CheckerWithHolderState();
}

class _CheckerWithHolderState extends State<CheckerWithHolder> {
  RxBool active = false.obs;
  @override
  Widget build(BuildContext context) {
    return InputHolderBox(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              (widget.title ?? '').tr,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorManager.greyColor,
              ),
            ),
          ),
          Center(
            child: Obx(() => CustomButton(
                  onTap: () {
                    active(!active.value);
                    widget.onTap(active.value);
                  },
                  width: inputHeight + 20,
                  height: inputHeight,
                  radius: radius,
                  borderColor: contentColor,
                  backgroundColor:
                      active.value ? Get.theme.primaryColor : Colors.white,
                  contentColor: active.value ? Colors.white : null,
                  text: active.value ? 'نعم' : 'لا',
                )),
          )
        ],
      ),
    );
  }
}

class FlammableMaterialsSheet extends StatelessWidget {
  const FlammableMaterialsSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      children: [
        CustomTextField(
          title: 'اذكر المواد القابلة للإشتعال الموودة بشحنتك',
          maxLines: 4,
        ),
        const Divider(
          color: ColorManager.greyColor,
        ),
        const SizedBox(height: 20),
        Center(
          child: CustomButton(
            height: inputHeight,
            width: 100,
            radius: radius,
            text: 'تأكيد',
            onTap: () {
              Get.back(result: true);
            },
          ),
        )
      ],
    );
  }
}
