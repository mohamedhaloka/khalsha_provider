import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:khalsha/features/payment/presentation/controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'دفع التسوية',
          style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
        backgroundColor: Get.theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: WebView(
        initialUrl: controller.transactionUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String url) {
          log(url, name: 'URL');

          if (url.toLowerCase().contains('id')) {
            String id = Uri.parse(url).queryParameters['id'].toString();
            Get.back(result: id);
          }
        },
      ),
    );
  }
}
