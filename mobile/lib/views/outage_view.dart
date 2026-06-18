import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:solar_mate/I18n/messages.dart';
import 'package:solar_mate/controllers/main_controller.dart';
import 'package:solar_mate/widgets/colors_widget.dart';
import 'package:solar_mate/utils/consumer_helper.dart';

class OutageView extends StatelessWidget {
  const OutageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppMessages.outageExpectations.tr,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        Text(
          AppMessages.outageExpectationsTip.tr,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white54,
          ),
        ),
        SizedBox(height: 20),
        Obx(
          () => Column(
            children: [
              GestureDetector(
                onTap: () {
                  MainController.to.selectedOutageIndex.value = 0;
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: MainController.to.selectedOutageIndex.value == 0
                          ? Colors.white12
                          : Colors.transparent,
                      width: 1,
                    ),
                    color: MainController.to.selectedOutageIndex.value == 0
                        ? Colors.black12
                        : darkColor,
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:
                              MainController.to.selectedOutageIndex.value == 0
                              ? const Color.fromARGB(62, 192, 171, 32)
                              : Colors.white10,
                        ),
                        child: Icon(
                          Icons.lightbulb_outlined,
                          size: 25,
                          color:
                              MainController.to.selectedOutageIndex.value == 0
                              ? primaryColor
                              : Colors.white54,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppMessages.emergenciesOnly.tr,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              AppMessages.emergenciesOnlyDescription.tr,
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  MainController.to.selectedOutageIndex.value = 1;
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: MainController.to.selectedOutageIndex.value == 1
                          ? Colors.white12
                          : Colors.transparent,
                      width: 1,
                    ),
                    color: MainController.to.selectedOutageIndex.value == 1
                        ? Colors.black12
                        : darkColor,
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:
                              MainController.to.selectedOutageIndex.value == 1
                              ? const Color.fromARGB(62, 192, 171, 32)
                              : Colors.white10,
                        ),
                        child: Icon(
                          Icons.warning_amber,
                          size: 25,
                          color:
                              MainController.to.selectedOutageIndex.value == 1
                              ? primaryColor
                              : Colors.white54,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppMessages.heavyUsage.tr,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              AppMessages.heavyUsageDescription.tr,
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  MainController.to.selectedOutageIndex.value = 2;
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: MainController.to.selectedOutageIndex.value == 2
                          ? Colors.white12
                          : Colors.transparent,
                      width: 1,
                    ),
                    color: MainController.to.selectedOutageIndex.value == 2
                        ? Colors.black12
                        : darkColor,
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:
                              MainController.to.selectedOutageIndex.value == 2
                              ? const Color.fromARGB(62, 192, 171, 32)
                              : Colors.white10,
                        ),
                        child: Icon(
                          Icons.playlist_add_check_rounded,
                          size: 25,
                          color:
                              MainController.to.selectedOutageIndex.value == 2
                              ? primaryColor
                              : Colors.white54,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppMessages.letMeChoose.tr,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              AppMessages.letMeChooseDescription.tr,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (MainController.to.selectedOutageIndex.value == 2) ...[
                const SizedBox(height: 10),
                const Divider(color: Colors.white24),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: darkColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white12, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppMessages.batteryHours.tr,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppMessages.batteryHoursTip.tr,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                if (MainController.to.batteryHours.value > 1) {
                                  MainController.to.batteryHours.value--;
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: 18,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                            Text(
                              '${MainController.to.batteryHours.value} ${AppMessages.hoursSuffix.tr}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (MainController.to.batteryHours.value < 24) {
                                  MainController.to.batteryHours.value++;
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.white24),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: MainController.to.selectedConsumers.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        final selectedConsumers = MainController.to.selectedConsumers;
                        selectedConsumers[index].isBatteryBackup =
                            !selectedConsumers[index].isBatteryBackup;
                        selectedConsumers[index].batteryCount =
                            selectedConsumers[index].isBatteryBackup ? 1 : 0;
                        selectedConsumers.refresh();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: MainController
                                    .to
                                    .selectedConsumers[index]
                                    .isBatteryBackup
                                ? primaryColor
                                : Colors.transparent,
                            width: 2,
                          ),
                          color: MainController
                                  .to
                                  .selectedConsumers[index]
                                  .isBatteryBackup
                              ? Colors.transparent
                              : darkColor,
                        ),
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: MainController
                                        .to
                                        .selectedConsumers[index]
                                        .isBatteryBackup
                                    ? const Color.fromARGB(62, 192, 171, 32)
                                    : Colors.white10,
                              ),
                              child: Icon(
                                Icons.battery_charging_full_rounded,
                                size: 30,
                                color: MainController
                                        .to
                                        .selectedConsumers[index]
                                        .isBatteryBackup
                                    ? primaryColor
                                    : Colors.white54,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          MainController.to.selectedConsumers[index].type,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      if (MainController.to.selectedConsumers[index].comment != null &&
                                          MainController.to.selectedConsumers[index].comment!.trim().isNotEmpty) ...[
                                        const SizedBox(width: 6),
                                        InkWell(
                                          onTap: () {
                                            ConsumerHelper.showCommentBottomSheet(
                                              context,
                                              MainController.to.selectedConsumers[index],
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Icon(
                                              Icons.info_outline_rounded,
                                              size: 16,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    '${AppMessages.systemTotal.tr} ${MainController.to.selectedConsumers[index].count} | ${MainController.to.selectedConsumers[index].normalWattage} ${AppMessages.wattage.tr} ${AppMessages.perUnit.tr} | ${MainController.to.selectedConsumers[index].threePhase ? AppMessages.ph3.tr : AppMessages.ph1.tr}',
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            final selectedConsumers =
                                                MainController.to.selectedConsumers;
                                            if (selectedConsumers[index]
                                                        .batteryCount >
                                                    0 &&
                                                selectedConsumers[index]
                                                    .isBatteryBackup) {
                                              selectedConsumers[index]
                                                  .batteryCount--;
                                              selectedConsumers.refresh();
                                            }

                                            if (selectedConsumers[index]
                                                    .batteryCount ==
                                                0) {
                                              selectedConsumers[index]
                                                      .isBatteryBackup =
                                                  false;
                                              selectedConsumers.refresh();
                                            }
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              size: 18,
                                              color: Colors.white54,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          MainController
                                              .to
                                              .selectedConsumers[index]
                                              .batteryCount
                                              .toString(),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            final selectedConsumers =
                                                MainController.to.selectedConsumers;
                                            if (selectedConsumers[index]
                                                    .batteryCount <
                                                selectedConsumers[index].count) {
                                              selectedConsumers[index]
                                                  .isBatteryBackup = true;
                                              selectedConsumers[index]
                                                  .batteryCount++;
                                              selectedConsumers.refresh();
                                            }
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              size: 18,
                                              color: Colors.white54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
