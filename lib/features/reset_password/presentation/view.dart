import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalsha/features/widgets/custom_text_field.dart';

import '../../../core/presentation/themes/colors_manager.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import 'get/controllers/controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'إعادة تعيين كلمة المرور',
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'من فضلك\nقم بكتابة رقم الهاتف أو البريد الإلكتروني',
            style: Get.textTheme.titleLarge!.copyWith(
              color: ColorManager.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          CustomTextField(
            title: 'الكود',
            controller: controller.code,
          ),
          CustomTextField(
            title: 'كلمة المرور الجديدة',
            controller: controller.password,
          ),
          CustomTextField(
            title: 'تأكيد كلمة المرور الجديدة',
            controller: controller.confirmationPassword,
          ),
          const SizedBox(height: 20),
          CustomButton.fillBlue(
            loading: controller.loading,
            onTap: controller.resetPassword,
            text: 'تغيير',
          ),
        ],
      ),
    );
  }
}
