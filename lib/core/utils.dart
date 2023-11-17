import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:khalsha/core/data/source/local/user_local.dart';
import 'package:khalsha/core/presentation/routes/app_routes.dart';
import 'package:khalsha/core/presentation/themes/colors_manager.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

const apiKey = 'AIzaSyC6vGIyIwOA5xR8WgM3-aG3qG3g43Ie8Zs';
const kField = 'field';
const kFile = 'file';

void showAlertMessage(String? msg) => Fluttertoast.showToast(
      msg: (msg ?? '').tr,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: ColorManager.secondaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );

Future<void> showDialog(
  String content, {
  bool showBackBtn = true,
  AlertType? type,
  String? title,
  String? doneText,
  String? backTxt,
  Color? doneColor,
  Color? backColor,
  void Function()? onBackTapped,
  void Function()? onDoneTapped,
}) =>
    Alert(
        context: Get.context!,
        type: type ?? AlertType.info,
        title: (title ?? '').tr,
        content: Text(
          content.tr,
          textAlign: TextAlign.center,
        ),
        buttons: [
          DialogButton(
            onPressed: onDoneTapped,
            color: doneColor ?? Get.theme.primaryColor,
            child: Text(
              (doneText ?? 'done').tr,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          if (showBackBtn)
            DialogButton(
              onPressed: () {
                Get.back();
                if (onBackTapped != null) onBackTapped();
              },
              color: backColor ?? ColorManager.errorColor,
              child: Text(
                (backTxt ?? 'back').tr,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
        ]).show();

void showLogOutAlert() => showDialog(
      'sure-log-out',
      type: AlertType.info,
      doneText: 'sign-out',
      doneColor: ColorManager.errorColor,
      backColor: ColorManager.primaryColor,
      onDoneTapped: () async {
        UserDataLocal.instance.remove();
        Get.offAllNamed(Routes.login);
      },
    );

void downloadImporterExporterApp() => showDialog(
      'يمكنك تحميل تطبيق المستورد/المصدر والإستفاده بكافة مميزاته',
      doneText: 'تحميل',
      onDoneTapped: () {
        Uri? storeUrl;

        if (Platform.isAndroid) {
          storeUrl = Uri.parse(
              'https://play.google.com/store/apps/details?id=com.khalsha.app');
        } else {
          storeUrl = Uri.parse(
              'https://apps.apple.com/us/app/khlasha-%D8%AE%D9%84%D8%B5%D9%87%D8%A7/id6456041627');
        }
        launchUrl(
          storeUrl,
          mode: LaunchMode.externalApplication,
        );
      },
      backColor: ColorManager.secondaryColor,
    );
