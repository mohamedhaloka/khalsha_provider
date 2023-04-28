import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:khalsha/features/otp/presentation/get/controllers/controller.dart';

import '../../../../core/presentation/themes/colors_manager.dart';

class ResendOTP extends GetView<OTPController> {
  const ResendOTP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Obx(() => Center(
            child: controller.timer.value == 0
                ? InkWell(
                    onTap: controller.resendCode,
                    child: Text('إرسال مرة أخرى',
                        style: Get.textTheme.titleMedium!.copyWith(
                          color: ColorManager.secondaryColor,
                        )),
                  )
                : CountdownTimer(
                    widgetBuilder: (_, time) {
                      return RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'يمكنك الإسال مرة أخرى بعد',
                          style:
                              Get.textTheme.titleMedium!.copyWith(fontSize: 16),
                          children: [
                            TextSpan(
                                text: " ${time!.sec} ثانية",
                                style: Get.textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Get.theme.primaryColor)),
                          ],
                        ),
                      );
                    },
                    onEnd: () {
                      try {
                        controller.timer(0);
                      } catch (e) {
                        log('Error in timer=> $e');
                      }
                    },
                    textStyle: Get.textTheme.bodyMedium!
                        .copyWith(color: Get.theme.primaryColor),
                    endTime: controller.timer.value,
                  ),
          )),
    );
  }
}
