import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:solar_mate/I18n/messages.dart';
import 'package:solar_mate/controllers/main_controller.dart';
import 'package:solar_mate/widgets/colors_widget.dart';

class SelectConsumersView extends StatelessWidget {
  const SelectConsumersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppMessages.selectConcurrentConsumer.tr,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        Text(
          AppMessages.selectConcurrentConsumerTip.tr,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white54,
          ),
        ),
        SizedBox(height: 20),
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: MainController.to.selectedConsumers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final selectedConsumers = MainController.to.selectedConsumers;
                  selectedConsumers[index].isConcurrent =
                      !selectedConsumers[index].isConcurrent;
                  selectedConsumers[index].concurrentCount =
                      selectedConsumers[index].isConcurrent ? 1 : 0;
                  selectedConsumers.refresh();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          MainController
                              .to
                              .selectedConsumers[index]
                              .isConcurrent
                          ? primaryColor
                          : Colors.transparent,
                      width: 2,
                    ),
                    color:
                        MainController.to.selectedConsumers[index].isConcurrent
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
                          color:
                              MainController
                                  .to
                                  .selectedConsumers[index]
                                  .isConcurrent
                              ? const Color.fromARGB(62, 192, 171, 32)
                              : Colors.white10,
                        ),
                        child: Icon(
                          Icons.bolt_outlined,
                          size: 30,
                          color:
                              MainController
                                  .to
                                  .selectedConsumers[index]
                                  .isConcurrent
                              ? primaryColor
                              : Colors.white54,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MainController.to.selectedConsumers[index].type,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            '${AppMessages.systemTotal.tr} ${MainController.to.selectedConsumers[index].count} | ${MainController.to.selectedConsumers[index].normalWattage} ${AppMessages.wattage.tr} ${AppMessages.perUnit.tr}',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20),
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
                                                .concurrentCount >
                                            0 &&
                                        selectedConsumers[index].isConcurrent) {
                                      selectedConsumers[index]
                                          .concurrentCount--;
                                      selectedConsumers.refresh();
                                    }

                                    if (selectedConsumers[index]
                                            .concurrentCount ==
                                        0) {
                                      selectedConsumers[index].isConcurrent =
                                          false;
                                      selectedConsumers.refresh();
                                    }
                                  },
                                  child: Padding(
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
                                      .concurrentCount
                                      .toString(),
                                ),
                                InkWell(
                                  onTap: () {
                                    final selectedConsumers =
                                        MainController.to.selectedConsumers;
                                    if (selectedConsumers[index]
                                            .concurrentCount <
                                        selectedConsumers[index].count) {
                                      selectedConsumers[index].isConcurrent =
                                          true;
                                      selectedConsumers[index]
                                          .concurrentCount++;
                                      selectedConsumers.refresh();
                                    }
                                  },
                                  child: Padding(
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
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
