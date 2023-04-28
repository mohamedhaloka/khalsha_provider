import 'package:flutter/material.dart';
import 'package:khalsha/core/presentation/themes/text_manager.dart';

import 'colors_manager.dart';

class ThemeManager {
  static ThemeData get theme => ThemeData(
        primaryColor: ColorManager.primaryColor,
        primaryColorLight: const Color(0xFFffffff),
        fontFamily: 'bahji',
        platform: TargetPlatform.iOS,
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorManager.primaryColor,
          elevation: 0.0,
        ),
        iconTheme: const IconThemeData(
          size: 30,
          color: ColorManager.primaryColor,
        ),
        textTheme: TextManager.textStyle,
      );
}
