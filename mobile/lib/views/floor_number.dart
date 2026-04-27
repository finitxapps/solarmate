import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:solar_mate/I18n/messages.dart';
import 'package:solar_mate/controllers/main_controller.dart';
import 'package:solar_mate/widgets/colors_widget.dart';

class FloorNumberView extends StatelessWidget {
  const FloorNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppMessages.floorNumber.tr,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: darkColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                AppMessages.optional.tr,
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
            ),
          ],
        ),

        SizedBox(height: 20),
        TextField(
          controller: MainController.to.floorNumberController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: AppMessages.floorNumber.tr,
            hintText: AppMessages.floorNumberHint.tr,
            hintStyle: TextStyle(color: Colors.white54),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ],
    );
  }
}
