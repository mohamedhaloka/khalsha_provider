import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/themes/colors_manager.dart';

class ChangeProfilePhoto extends StatelessWidget {
  const ChangeProfilePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: Get.width,
            height: 130,
            color: ColorManager.lightGreyColor,
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF35637E),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: Color(0xFF35637E),
                      child: Image.asset('assets/images/app-icon.png'),
                    ),
                  ),
                ),
                const Text('تغيير الصورة الشخصية')
              ],
            ),
          )
        ],
      ),
    );
  }
}
