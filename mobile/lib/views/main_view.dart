import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solar_mate/I18n/messages.dart';
import 'package:solar_mate/controllers/background_animation_controller.dart';
import 'package:solar_mate/controllers/locale_controller.dart';
import 'package:solar_mate/controllers/main_controller.dart';
import 'package:solar_mate/gen/assets.gen.dart';
import 'package:solar_mate/widgets/colors_widget.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final ThemeData themeData = Theme.of(context);
    RxString selectedLang = Get.locale?.languageCode.obs ?? 'fa'.obs;

    // Initialize animation controller (only once)
    final animationController = Get.put(BackgroundAnimationController());

    return Obx(() {
      final animValue = animationController.animationValue.value;
      final currentTopColor = Color.lerp(
        themeData.colorScheme.primary, // Dark Purple - same as background
        themeData.colorScheme.secondary, // Light Purple - same as background
        animValue,
      )!;
      final currentBottomColor = Color.lerp(
        themeData.colorScheme.secondary, // Light Purple - same as background
        themeData.colorScheme.primary, // Dark Purple - same as background
        animValue,
      )!;

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: currentTopColor,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: currentBottomColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.transparent,
            drawer: Drawer(
              backgroundColor: currentBottomColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.lerp(
                        themeData.colorScheme.primary,
                        themeData.colorScheme.secondary,
                        animValue,
                      )!,
                      Color.lerp(
                        themeData.colorScheme.secondary,
                        themeData.colorScheme.primary,
                        animValue,
                      )!,
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Text(
                        AppMessages.appName.tr,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 25),
                      Divider(),
                      ListTile(
                        leading: Assets.images.icHome.image(
                          width: 25,
                          height: 25,
                          color: Colors.white,
                        ),
                        title: Text(
                          AppMessages.mainPage.tr,
                          style: const TextStyle(fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          MainController.to.currentPageIndex.value = 0;
                        },
                      ),
                      ListTile(
                        leading: Assets.images.icAbout.image(
                          width: 25,
                          height: 25,
                          color: Colors.white,
                        ),
                        title: Text(
                          AppMessages.about.tr,
                          style: const TextStyle(fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Assets.images.icContact.image(
                          width: 25,
                          height: 25,
                          color: Colors.white,
                        ),
                        title: Text(
                          AppMessages.contact.tr,
                          style: const TextStyle(fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.language,
                          color: Colors.white,
                          size: 26,
                        ),
                        title: Text(
                          AppMessages.language.tr,
                          style: const TextStyle(fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Get.defaultDialog(
                            titleStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            title: AppMessages.appLanguage.tr,
                            content: Obx(
                              () => Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      selectedLang.value = 'fa';
                                    },
                                    borderRadius: BorderRadius.circular(50),
                                    child: Row(
                                      children: [
                                        Radio<String>(
                                          value: 'fa',
                                          groupValue: selectedLang.value,
                                          onChanged: (value) {
                                            selectedLang.value = 'fa';
                                          },
                                        ),
                                        Text(AppMessages.persian.tr),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  InkWell(
                                    onTap: () {
                                      selectedLang.value = 'en';
                                    },
                                    borderRadius: BorderRadius.circular(50),
                                    child: Row(
                                      children: [
                                        Radio<String>(
                                          value: 'en',
                                          groupValue: selectedLang.value,
                                          onChanged: (value) {
                                            selectedLang.value = 'en';
                                          },
                                        ),
                                        Text(AppMessages.english.tr),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            buttonColor: Colors.white,
                            confirmTextColor: Colors.black,
                            cancelTextColor: Colors.white,
                            textCancel: AppMessages.cancel.tr,
                            textConfirm: AppMessages.confirm.tr,
                            onConfirm: () {
                              GetStorage().write('locale', selectedLang.value);
                              Get.updateLocale(Locale(selectedLang.value));
                              Get.find<LocaleController>().updateTheme();
                              Get.back();
                            },
                            onCancel: () => Get.back(),
                          );
                        },
                      ),
                      const Spacer(),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          '${AppMessages.version.tr} 1.0',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.lerp(
                      themeData.colorScheme.primary,
                      themeData.colorScheme.secondary,
                      animValue,
                    )!,
                    Color.lerp(
                      themeData.colorScheme.secondary,
                      themeData.colorScheme.primary,
                      animValue,
                    )!,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsGeometry.fromLTRB(20, 20, 20, 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            scaffoldKey.currentState?.openDrawer();
                          },
                          child: const Icon(
                            Icons.menu_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                AppMessages.appName.tr,
                                style: themeData.textTheme.headlineMedium!
                                    .copyWith(
                                      fontSize: 28,
                                      letterSpacing: -1,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                              Text(
                                '${AppMessages.step.tr} ${MainController.to.currentPageIndex.value + 1} ${AppMessages.of.tr} ${MainController.to.pages.length}',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: LinearProgressIndicator(
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(20),
                      value:
                          100 *
                          (MainController.to.currentPageIndex.value + 1) /
                          MainController.to.pages.length /
                          100,
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => Center(
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white38,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        MainController.to.pages[MainController
                                            .to
                                            .currentPageIndex
                                            .value],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(color: Colors.white38),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (MainController
                                                .to
                                                .currentPageIndex
                                                .value >
                                            0) {
                                          MainController.to.previousPage();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black12,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 40,
                                        ),
                                      ),

                                      child: Text(
                                        AppMessages.previous.tr,
                                        style: TextStyle(
                                          color:
                                              MainController
                                                      .to
                                                      .currentPageIndex
                                                      .value >
                                                  0
                                              ? Colors.white
                                              : Colors.white54,
                                        ),
                                      ),
                                    ),

                                    if (MainController
                                            .to
                                            .currentPageIndex
                                            .value <
                                        MainController.to.pages.length - 1) ...{
                                      ElevatedButton(
                                        onPressed: MainController.to.nextPage,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 40,
                                          ),
                                        ),
                                        child: Text(
                                          AppMessages.next.tr,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    } else ...{
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 45,
                                          ),
                                        ),
                                        child: Text(
                                          AppMessages.calculate.tr,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    },
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
