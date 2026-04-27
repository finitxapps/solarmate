import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solar_mate/gen/fonts.gen.dart';
import 'package:solar_mate/widgets/colors_widget.dart';

class ThemeConfig {
  static ThemeData getTheme() {
    return ThemeData(
      textTheme: textTheme(),
      useMaterial3: true,
      scaffoldBackgroundColor: primaryColor,
      colorScheme: colorScheme,
      fontFamily: _getFontFamily(),
      highlightColor: Colors.transparent,
      splashColor: Colors.grey.shade800,
    );
  }

  static String _getFontFamily() {
    final currentLocale =
        Get.locale?.languageCode ?? GetStorage().read<String>('locale') ?? 'en';
    return currentLocale == 'en' ? FontFamily.geist : FontFamily.iranYekan;
  }
}

ColorScheme colorScheme = ColorScheme.dark(
  primary: primaryColor,
  secondary: secondaryColor,
  brightness: Brightness.dark,
  primaryContainer: primaryColor,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onTertiary: Colors.white,
  surface: darkColor,
  surfaceTint: darkColor,
  inverseSurface: Colors.white,
  onSurface: Colors.white,
  outline: Colors.grey,
  outlineVariant: Colors.white60,
  tertiary: Colors.grey[600],
  onTertiaryContainer: Colors.grey[800],
  tertiaryContainer: darkColor,
);

TextTheme textTheme() {
  return const TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 0,
    ),
    displayMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 0,
    ),
    displaySmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 0,
    ),
    headlineLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: primaryColor,
      letterSpacing: 0,
    ),
    headlineMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 0,
    ),
    headlineSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: primaryColor,
      letterSpacing: 0,
    ),
    titleLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
      letterSpacing: 0,
    ),
    titleMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
      letterSpacing: 0,
    ),
    titleSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
      letterSpacing: 0,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 0,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 0,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 0,
    ),
    bodyLarge: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 0,
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 0,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.white,
      letterSpacing: 0,
    ),
  );
}
