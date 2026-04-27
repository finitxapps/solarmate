import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:solar_mate/I18n/messages.dart';
import 'package:solar_mate/controllers/main_controller.dart';

class RoofView extends StatelessWidget {
  const RoofView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppMessages.roofArea.tr,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        Text(
          AppMessages.roofAreaTip.tr,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white54,
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: MainController.to.roofAreaController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: AppMessages.roofArea.tr,
            hintText: AppMessages.roofAreaHint.tr,
            hintStyle: TextStyle(color: Colors.white54),
            suffix: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                AppMessages.roofAreaSuffix.tr,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ],
    );
  }
}
