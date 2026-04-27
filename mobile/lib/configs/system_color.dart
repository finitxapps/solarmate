import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum SystemColor { secondary, background, primary }

void systemColor({required SystemColor systemColor}) {
  final ThemeData themeData = Theme.of(Get.context!);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: systemColor == SystemColor.secondary
          ? themeData.colorScheme.secondary
          : systemColor == SystemColor.background
          ? themeData.colorScheme.surface
          : themeData.colorScheme.primary,
      statusBarIconBrightness: systemColor == SystemColor.background
          ? themeData.colorScheme.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark
          : Brightness.light,
      systemNavigationBarColor: systemColor == SystemColor.secondary
          ? themeData.colorScheme.secondary
          : systemColor == SystemColor.background
          ? themeData.colorScheme.surface
          : themeData.colorScheme.primary,
      systemNavigationBarIconBrightness: systemColor == SystemColor.background
          ? themeData.colorScheme.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark
          : Brightness.light,
    ),
  );
}
