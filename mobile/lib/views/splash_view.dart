import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_mate/I18n/messages.dart';
import 'package:solar_mate/configs/system_color.dart';
import 'package:solar_mate/controllers/main_controller.dart';
import 'package:solar_mate/gen/assets.gen.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    systemColor(systemColor: SystemColor.primary);
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Future.wait([MainController.to.getConsumers()]),
          builder: (context, asyncSnapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Center(
                  child: Text(
                    AppMessages.appName.tr,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // Assets.images.logoType.image(width: 200, height: 200),
                const Spacer(),
                Assets.images.loading.image(
                  width: 50,
                  height: 50,
                  color: Colors.white,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
