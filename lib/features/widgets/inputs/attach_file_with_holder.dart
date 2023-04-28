import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/themes/colors_manager.dart';
import '../../../core/inputs_style.dart';
import 'input_holder_box.dart';

class AttachFileWithHolder extends StatelessWidget {
  const AttachFileWithHolder({
    Key? key,
    this.title,
    this.errorMsg,
    this.onChooseFile,
    required this.file,
  }) : super(key: key);
  final String? title, errorMsg;
  final Rx<File> file;
  final void Function(String)? onChooseFile;

  @override
  Widget build(BuildContext context) {
    return InputHolderBox(
      Column(
        children: [
          if (title != null) ...[
            Text(
              title ?? '',
              style: Get.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorManager.greyColor,
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
          const SizedBox(height: 5),
          InkWell(
            onTap: chooseFile,
            child: Center(
              child: Obx(() {
                final isSelected = file.value.path != '';
                return Container(
                  height: inputHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? ColorManager.primaryColor : null,
                    border: Border.all(color: ColorManager.lightGreyColor),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(radius)),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/upload-file.svg',
                        color: isSelected ? Colors.white : null,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isSelected ? 'تم' : 'إرفاق',
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : ColorManager.greyColor,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      errorText: errorMsg,
    );
  }

  void chooseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) return;
    file(File(result.files.single.path!));
    if (onChooseFile == null) return;
    onChooseFile!(result.files.single.path!);
  }
}
