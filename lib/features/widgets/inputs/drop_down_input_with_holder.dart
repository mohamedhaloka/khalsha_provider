import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/themes/colors_manager.dart';
import '../../../core/inputs_style.dart';
import '../custom_drop_down.dart';
import 'input_holder_box.dart';

class DropDownInputWithHolder extends StatelessWidget {
  const DropDownInputWithHolder({
    Key? key,
    this.hint,
    this.title,
    this.errorText,
    this.onTap,
    required this.dropValue,
    required this.source,
  }) : super(key: key);
  final String? title, hint, errorText;
  final List<DropdownMenuItem> source;
  final RxString dropValue;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return InputHolderBox(
      Row(
        children: [
          if (title != null) ...[
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title ?? '',
                      style: Get.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorManager.greyColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 12, 0),
                    child: InkWell(
                      onTap: () {},
                      child: SvgPicture.asset('assets/images/icons/info.svg'),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Expanded(
            child: CustomDropDown(
              radius: radius,
              height: inputHeight,
              hint: hint ?? 'إختر',
              dropVal: dropValue,
              onTap: onTap,
              isExpanded: true,
              source: source,
              hintColor: ColorManager.greyColor,
              iconColor: ColorManager.greyColor,
            ),
          ),
        ],
      ),
      errorText: errorText,
    );
  }
}
