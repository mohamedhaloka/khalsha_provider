import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/themes/colors_manager.dart';
import '../../../core/inputs_style.dart';
import '../custom_button.dart';
import '../custom_text_field.dart';

class AddNotesSheet extends StatelessWidget {
  const AddNotesSheet({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      children: [
        CustomTextField(
          title: text,
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
