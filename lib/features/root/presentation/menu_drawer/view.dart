import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khalsha/features/root/presentation/get/controllers/controller.dart';

import 'package:khalsha/core/data/source/local/intro_hint_count_locale.dart';
import 'package:khalsha/core/presentation/themes/colors_manager.dart';
import 'package:khalsha/features/root/presentation/menu_drawer/menu_header.dart';
import 'package:khalsha/features/root/presentation/menu_drawer/menu_items.dart';

class MenuDrawerView extends StatefulWidget {
  const MenuDrawerView({Key? key}) : super(key: key);

  @override
  State<MenuDrawerView> createState() => _MenuDrawerViewState();
}

class _MenuDrawerViewState extends State<MenuDrawerView> {
  final controller = Get.find<RootController>();
  Timer? timer;

  Intro intro = Intro(
    noAnimation: false,
    stepCount: 1,
    borderRadius: const BorderRadius.all(Radius.circular(4)),
    widgetBuilder: StepWidgetBuilder.useDefaultTheme(
      texts: ['يمكنك استعراض طلبات العملاء من خلال الضغط هنا.'],
      buttonTextBuilder: (curr, total) => 'حسناً',
    ),
  );

  @override
  void initState() {
    final Map<String, dynamic> introMap = IntroHintCountLocal.instance.get();
    String nameKey = 'new_orders_drawer';
    if ((introMap[nameKey] ?? 0) >= 2) return;
    timer = Timer(
      const Duration(seconds: 1),
      () {
        intro.start(context);
        IntroHintCountLocal.instance.save(nameKey);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
      )),
      child: ListView(
        children: [
          const MenuHeader(),
          MenuItems(intro: intro),
          InkWell(
            onTap: controller.showLogOutDialog,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/icons/sign-out.svg'),
                const SizedBox(width: 6),
                Text(
                  'تسجيل خروج',
                  style: Get.textTheme.titleMedium!.copyWith(
                    color: ColorManager.darkTobyColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
