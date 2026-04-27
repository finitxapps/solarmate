import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundAnimationController extends GetxController
    with GetTickerProviderStateMixin {
  static BackgroundAnimationController get to =>
      Get.put<BackgroundAnimationController>(BackgroundAnimationController());

  late AnimationController animationController;
  late Animation<double> animation;

  final RxDouble animationValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    animationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    // Listen to animation changes and update the observable
    animation.addListener(() {
      animationValue.value = animation.value;
    });

    // Start the animation
    animationController.repeat(reverse: true);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
