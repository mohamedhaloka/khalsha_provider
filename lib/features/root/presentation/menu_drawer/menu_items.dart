import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khalsha/core/data/models/item_model.dart';
import 'package:khalsha/core/presentation/themes/colors_manager.dart';
import 'package:khalsha/features/root/presentation/get/controllers/controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuItems extends GetView<RootController> {
  const MenuItems({Key? key, required this.intro}) : super(key: key);
  final Intro intro;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 25),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, int index) => _MenuItem(
        controller.menu[index],
        key: index == 2 ? intro.keys[0] : null,
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemCount: controller.menu.length,
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem(this.item, {Key? key}) : super(key: key);
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
        if (item.id == 5) {
          final String url = GetPlatform.isAndroid
              ? 'https://play.google.com/store/apps/details?id=com.app.khalsha.provider'
              : 'https://apps.apple.com/us/app/%D8%AE%D8%AF%D9%85%D8%A7%D8%AA-%D8%AE%D9%84%D8%B5%D9%87%D8%A7/id6467006705';
          final String shareTxt =
              '''يمكنك تحميل تطبيق خلصها لمزودى الخدمات عن طريق الرابط التالي
$url''';
          Share.share(shareTxt);
          return;
        }

        if (Uri.parse(item.route!).isAbsolute) {
          final url = Uri.parse(item.route!);
          launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          );
          return;
        }

        if (item.route == null) return;
        Get.toNamed(
          item.route!,
          arguments: item.arguments,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Row(
          children: [
            SvgPicture.asset('assets/images/icons/${item.image}.svg'),
            const SizedBox(width: 22),
            Expanded(
                child: Text(
              item.text.tr,
              style: Get.textTheme.titleSmall!.copyWith(
                color: ColorManager.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
