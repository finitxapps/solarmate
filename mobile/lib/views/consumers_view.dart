import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/utils.dart';
import 'package:solar_mate/I18n/messages.dart';
import 'package:solar_mate/widgets/colors_widget.dart';
import 'package:solar_mate/controllers/main_controller.dart';

class ConsumersView extends StatelessWidget {
  const ConsumersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final consumersModelList = MainController.to.consumerList;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppMessages.selectConsumer.tr,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          Text(
            AppMessages.selectConsumerTip.tr,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white54,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 70,
            child: ListView.builder(
              itemCount: consumersModelList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, listIndex) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      backgroundColor: darkColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.tv, size: 14, color: Colors.white54),
                        Text(
                          consumersModelList[listIndex].type,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          '${consumersModelList[listIndex].normalWattage} ${AppMessages.wattage.tr}',
                          style: TextStyle(color: Colors.white54, fontSize: 10),
                        ),
                      ],
                    ),
                    onPressed: () {
                      MainController.to.selectedConsumers.addIf(
                        !MainController.to.selectedConsumers.contains(
                          consumersModelList[listIndex],
                        ),
                        consumersModelList[listIndex],
                      );
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: darkColor,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: MainController.to.selectedConsumers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white10,
                              ),
                              child: Icon(
                                Icons.tv,
                                size: 20,
                                color: Colors.white54,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  MainController
                                      .to
                                      .selectedConsumers[index]
                                      .type,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.bolt_outlined,
                                      size: 14,
                                      color: Colors.white54,
                                    ),
                                    Text(
                                      '${MainController.to.selectedConsumers[index].normalWattage} ${AppMessages.wattage.tr} ${AppMessages.perUnit.tr}',
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Spacer(),

                            InkWell(
                              onTap: () {
                                MainController.to.selectedConsumers.removeAt(
                                  index,
                                );
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.white54,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
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
                                  if (selectedConsumers[index].count > 1) {
                                    selectedConsumers[index].count--;
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
                                MainController.to.selectedConsumers[index].count
                                    .toString(),
                              ),
                              InkWell(
                                onTap: () {
                                  final selectedConsumers =
                                      MainController.to.selectedConsumers;
                                  selectedConsumers[index].count++;
                                  selectedConsumers.refresh();
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
                        SizedBox(height: 10),
                        if (index !=
                            MainController.to.selectedConsumers.length - 1)
                          Divider(color: Colors.white12),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
