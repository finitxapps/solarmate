import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_mate/I18n/messages.dart';
import 'package:solar_mate/models/consumer_model.dart';
import 'package:solar_mate/widgets/colors_widget.dart';

class ConsumerHelper {
  static void showCommentBottomSheet(BuildContext context, ConsumerItem item) {
    if (item.comment == null || item.comment!.trim().isEmpty) return;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        decoration: const BoxDecoration(
          color: darkColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handlebar indicator
            Center(
              child: Container(
                width: 44,
                height: 5,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: primaryColor,
                  size: 26,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.type,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              AppMessages.detailsTitle.tr,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12, width: 1),
              ),
              child: Text(
                item.comment!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      barrierColor: Colors.black54,
      isDismissible: true,
      enableDrag: true,
    );
  }
}
