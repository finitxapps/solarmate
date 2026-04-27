import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solar_mate/I18n/translation.dart';
import 'package:solar_mate/configs/theme_data_config.dart';
import 'package:solar_mate/controllers/locale_controller.dart';
import 'package:solar_mate/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  final saved = GetStorage().read<String>('locale');
  Locale? initialLocale;
  if (saved != null) {
    initialLocale = Locale(saved);
  }
  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {
  final Locale? initialLocale;
  const MyApp({super.key, this.initialLocale});
  static final List<GetPage<dynamic>> getPages = [
    GetPage(name: '/', page: () => const SplashView()),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocaleController>(
      init: LocaleController(),
      builder: (localeController) => GetMaterialApp(
        theme: ThemeConfig.getTheme(),
        initialRoute: '/',
        getPages: getPages,
        textDirection: TextDirection.ltr,
        translations: AppTranslation(),
        locale: initialLocale ?? const Locale('fa'),
        supportedLocales: const [Locale('fa'), Locale('en')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          final locale = Get.locale ?? initialLocale ?? const Locale('fa');
          final isRtl = locale.languageCode == 'fa';
          return Directionality(
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: child!,
          );
        },
      ),
    );
  }
}
