import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/themes/colors_manager.dart';
import '../../../core/inputs_style.dart';
import '../custom_text_field.dart';
import 'input_holder_box.dart';

class TextFieldInputWithHolder extends StatelessWidget {
  const TextFieldInputWithHolder({
    Key? key,
    this.hint,
    this.title,
    this.controller,
    this.padding,
    this.maxLines,
    this.errorText,
    this.enabled,
    this.onSaved,
    this.onChanged,
    this.keyboardType,
    this.onTap,
  }) : super(key: key);
  final String? title, hint, errorText;
  final TextEditingController? controller;
  final EdgeInsets? padding;
  final bool? enabled;
  final void Function()? onTap;
  final int? maxLines;
  final void Function(String value)? onChanged;
  final void Function(String? value)? onSaved;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return InputHolderBox(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title ?? '',
              style: Get.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorManager.greyColor,
              ),
            ),
          ],
          CustomTextField(
            hint: hint,
            controller: controller,
            padding: EdgeInsets.zero,
            height: inputHeight,
            radius: radius,
            onChanged: onChanged,
            onSaved: onSaved,
            textAlign: TextAlign.center,
            enabled: enabled,
            onTap: onTap,
            maxLines: maxLines,
            keyboardType: keyboardType,
            contentPadding: contentPadding,
            borderSide: inputBorderSide,
            contentColor: contentColor,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
      errorText: errorText,
      padding: padding,
    );
  }
}
