import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:solar_mate/controllers/main_controller.dart';
import 'package:solar_mate/utils/price_formatter.dart';
import 'package:solar_mate/widgets/colors_widget.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'پکیج های پیشنهادی:',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),

        SizedBox(height: 20),

        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: MainController.to.resultModel.value?.packages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (MainController.to.selectedPackageIndex.value == index) {
                  MainController.to.selectedPackageIndex.value = -1;
                } else {
                  MainController.to.selectedPackageIndex.value = index;
                }
              },
              child: Obx(
                () => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          MainController.to.selectedPackageIndex.value == index
                          ? Colors.white12
                          : Colors.transparent,
                      width: 1,
                    ),
                    color: MainController.to.selectedPackageIndex.value == index
                        ? Colors.black12
                        : darkColor,
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'اینورتر:',
                        style: themeData.textTheme.headlineSmall!.copyWith(
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'نام: ${MainController.to.resultModel.value?.packages[index].inverter.name}\nقدرت: ${MainController.to.resultModel.value?.packages[index].inverter.maxPower}\nقیمت: ${MainController.to.resultModel.value?.packages[index].inverter.price.toMoney()}',
                      ),
                      SizedBox(height: 5),

                      Text(
                        'پنل:',
                        style: themeData.textTheme.headlineSmall!.copyWith(
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 5),

                      Text(
                        'نام: ${MainController.to.resultModel.value?.packages[index].panel.name}\nقدرت: ${MainController.to.resultModel.value?.packages[index].panel.power}\nقیمت: ${MainController.to.resultModel.value?.packages[index].panel.price.toMoney()}',
                      ),
                      SizedBox(height: 5),

                      Row(
                        children: [
                          Text(
                            'تعداد پنل:',
                            style: themeData.textTheme.headlineSmall!.copyWith(
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: 10),

                          Text(
                            MainController
                                    .to
                                    .resultModel
                                    .value
                                    ?.packages[index]
                                    .panelCount
                                    .toString() ??
                                '',
                          ),
                        ],
                      ),
                      SizedBox(height: 5),

                      Row(
                        children: [
                          Text(
                            'قیمت کل:',
                            style: themeData.textTheme.headlineSmall!.copyWith(
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: 10),

                          Text(
                            MainController
                                    .to
                                    .resultModel
                                    .value
                                    ?.packages[index]
                                    .totalPrice
                                    .toMoney() ??
                                '',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 10),

        Text(
          'مخارج ثابت:',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: darkColor,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: MainController.to.resultModel.value?.otherCosts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MainController
                              .to
                              .resultModel
                              .value
                              ?.otherCosts[index]
                              .name ??
                          '',
                      style: themeData.textTheme.headlineMedium!.copyWith(
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'قیمت: ${MainController.to.resultModel.value?.otherCosts[index].price.toMoney()}\nتوضیحات: ${MainController.to.resultModel.value?.otherCosts[index].description}',
                    ),
                    SizedBox(height: 10),
                    if (index !=
                        MainController.to.resultModel.value!.otherCosts.length -
                            1)
                      Divider(color: Colors.white12),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
