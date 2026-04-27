import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_mate/I18n/messages.dart';
import 'package:solar_mate/controllers/main_controller.dart';
import 'package:solar_mate/widgets/colors_widget.dart';

class MeterTypeView extends StatelessWidget {
  const MeterTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    MainController mainController = MainController.to;
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppMessages.meterType.tr,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(
                color: mainController.selectedMeterType.value == '0'
                    ? primaryColor
                    : Colors.white54,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: RadioListTile<String>(
              title: Text(AppMessages.ph1.tr),
              value: '0',
              groupValue: mainController.selectedMeterType.value,
              onChanged: mainController.selectMeterType,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(
                color: mainController.selectedMeterType.value == '1'
                    ? primaryColor
                    : Colors.white54,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: RadioListTile<String>(
              title: Text(AppMessages.ph3.tr),
              value: '1',
              groupValue: mainController.selectedMeterType.value,
              onChanged: mainController.selectMeterType,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(
                color: mainController.selectedMeterType.value == '2'
                    ? primaryColor
                    : Colors.white54,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: RadioListTile<String>(
              title: Text(AppMessages.none.tr),
              value: '2',
              groupValue: mainController.selectedMeterType.value,
              onChanged: mainController.selectMeterType,
            ),
          ),
        ],
      );
    });
  }
}
