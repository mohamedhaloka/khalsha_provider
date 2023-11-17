import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalsha/features/home/presentation/get/controllers/controller.dart';
import 'package:video_cached_player/video_cached_player.dart';

class IntroVideo extends GetView<HomeController> {
  const IntroVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 200,
      child: Obx(() => controller.showVideo.value
          ? AspectRatio(
              aspectRatio: controller.videoController.value.aspectRatio,
              child: CachedVideoPlayer(controller.videoController),
            )
          : const SizedBox()),
    );
  }
}
