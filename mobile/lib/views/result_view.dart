import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_mate/I18n/messages.dart';
import 'package:solar_mate/controllers/main_controller.dart';
import 'package:solar_mate/utils/price_formatter.dart';
import 'package:solar_mate/widgets/colors_widget.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Obx(() {
      final result = MainController.to.resultModel.value;
      if (result == null) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'هیچ اطلاعاتی دریافت نشد.',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        );
      }

      final fixedCostsSum = result.otherCosts.fold<int>(0, (sum, item) => sum + item.price);
      final selectedIndex = MainController.to.selectedPackageIndex.value;
      final selectedPackage = selectedIndex >= 0 && selectedIndex < result.packages.length
          ? result.packages[selectedIndex]
          : null;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome_rounded, color: primaryColor, size: 28),
              const SizedBox(width: 8),
              Text(
                AppMessages.recommendedPackages.tr,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: result.packages.length,
            itemBuilder: (context, index) {
              final package = result.packages[index];
              final isSelected = MainController.to.selectedPackageIndex.value == index;

              return GestureDetector(
                onTap: () {
                  if (MainController.to.selectedPackageIndex.value == index) {
                    MainController.to.selectedPackageIndex.value = -1;
                  } else {
                    MainController.to.selectedPackageIndex.value = index;
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.white12,
                      width: isSelected ? 2 : 1,
                    ),
                    color: isSelected
                        ? primaryColor.withValues(alpha: 0.08)
                        : darkColor,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.15),
                              blurRadius: 12,
                              spreadRadius: 2,
                            )
                          ]
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header of Card: Badge & Select status
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? primaryColor
                                    : primaryColor.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                package.type.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.black : primaryColor,
                                ),
                              ),
                            ),
                            if (isSelected)
                              const CircleAvatar(
                                radius: 12,
                                backgroundColor: primaryColor,
                                child: Icon(
                                  Icons.check_rounded,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              )
                            else
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white.withValues(alpha: 0.1),
                                child: const SizedBox(),
                              ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.white12, height: 1),
                      // Details (Inverter & Panel)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Inverter Detail Row
                            _buildItemRow(
                              context: context,
                              title: AppMessages.inverter.tr,
                              name: package.inverter.name,
                              powerText: '${package.inverter.maxPower} W | ${package.inverter.threePhase ? AppMessages.ph3.tr : AppMessages.ph1.tr}',
                              priceText: package.inverterCount > 1
                                  ? '${AppMessages.unitPrice.tr}: ${package.inverter.price.toMoney()}  |  ${AppMessages.total.tr}: ${(package.inverter.price * package.inverterCount).toMoney()}'
                                  : package.inverter.price.toMoney(),
                              imageUrl: package.inverter.image,
                              icon: Icons.settings_input_component_rounded,
                              extraInfo: '${AppMessages.inverterCount.tr}: ${package.inverterCount}',
                            ),
                            const SizedBox(height: 16),
                            const Divider(color: Colors.white12, height: 1),
                            const SizedBox(height: 16),
                            // Panel Detail Row
                            _buildItemRow(
                              context: context,
                              title: AppMessages.panel.tr,
                              name: package.panel.name,
                              powerText: '${package.panel.power} W',
                              priceText: package.panelCount > 1
                                  ? '${AppMessages.unitPrice.tr}: ${package.panel.price.toMoney()}  |  ${AppMessages.total.tr}: ${(package.panel.price * package.panelCount).toMoney()}'
                                  : package.panel.price.toMoney(),
                              imageUrl: package.panel.image,
                              icon: Icons.solar_power_rounded,
                              extraInfo: '${AppMessages.panelCount.tr}: ${package.panelCount}',
                            ),
                            // Battery Detail Row (if available)
                            if (package.batteryConfig != null) ...[
                              const SizedBox(height: 16),
                              const Divider(color: Colors.white12, height: 1),
                              const SizedBox(height: 16),
                              _buildItemRow(
                                context: context,
                                title: AppMessages.battery.tr,
                                name: package.batteryConfig!.name,
                                powerText: '${package.batteryConfig!.capacityWh} Wh',
                                priceText: package.batteryConfig!.count > 1
                                    ? '${AppMessages.unitPrice.tr}: ${package.batteryConfig!.price.toMoney()}  |  ${AppMessages.total.tr}: ${package.batteryConfig!.totalCost.toMoney()}'
                                    : package.batteryConfig!.totalCost.toMoney(),
                                imageUrl: package.batteryConfig!.image,
                                icon: Icons.battery_charging_full_rounded,
                                extraInfo: '${AppMessages.count.tr}: ${package.batteryConfig!.count}',
                              ),
                            ],
                          ],
                        ),
                      ),
                      const Divider(color: Colors.white12, height: 1),
                      // Footer (Total Cost)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.15),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(24),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppMessages.totalPrice.tr,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              package.totalPrice.toMoney(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: primaryColor,
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
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.receipt_long_rounded, color: primaryColor, size: 28),
              const SizedBox(width: 8),
              Text(
                AppMessages.otherCosts.tr,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: darkColor,
              border: Border.all(color: Colors.white12, width: 1),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: result.otherCosts.length,
              itemBuilder: (context, index) {
                final cost = result.otherCosts[index];
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cost.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            cost.price.toMoney(),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cost.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (index != result.otherCosts.length - 1) ...[
                        const SizedBox(height: 16),
                        const Divider(color: Colors.white12, height: 1),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.flash_on_rounded, color: primaryColor, size: 28),
              const SizedBox(width: 8),
              Text(
                AppMessages.systemCapacityTitle.tr,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: darkColor,
              border: Border.all(color: Colors.white12, width: 1),
            ),
            child: Column(
              children: [
                _buildSpecRow(
                  label: AppMessages.totalConsumersLoad.tr,
                  value: '${result.calculations.totalWattage} W',
                ),
                const SizedBox(height: 12),
                const Divider(color: Colors.white12, height: 1),
                const SizedBox(height: 12),
                _buildSpecRow(
                  label: AppMessages.totalPanelGeneration.tr,
                  value: selectedPackage != null
                      ? '${selectedPackage.panel.power * selectedPackage.panelCount} W'
                      : '-',
                ),
                const SizedBox(height: 12),
                const Divider(color: Colors.white12, height: 1),
                const SizedBox(height: 12),
                _buildSpecRow(
                  label: AppMessages.maxConcurrentLoad.tr,
                  value: '${result.calculations.totalConcurrentWattage} W',
                ),
                const SizedBox(height: 12),
                const Divider(color: Colors.white12, height: 1),
                const SizedBox(height: 12),
                _buildSpecRow(
                  label: AppMessages.maxSurgeLoad.tr,
                  value: '${result.calculations.totalSurgeWattage} W',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.calculate_rounded, color: primaryColor, size: 28),
              const SizedBox(width: 8),
              Text(
                AppMessages.projectCostBreakdownTitle.tr,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: darkColor,
              border: Border.all(color: Colors.white12, width: 1),
            ),
            child: Column(
              children: [
                _buildSpecRow(
                  label: AppMessages.selectedPackageCost.tr,
                  value: selectedPackage != null
                      ? selectedPackage.totalPrice.toMoney()
                      : '-',
                ),
                const SizedBox(height: 12),
                const Divider(color: Colors.white12, height: 1),
                const SizedBox(height: 12),
                _buildSpecRow(
                  label: AppMessages.fixedSetupCosts.tr,
                  value: fixedCostsSum.toMoney(),
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.white24, height: 1, thickness: 1.5),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppMessages.totalProjectCost.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      selectedPackage != null
                          ? (selectedPackage.totalPrice + fixedCostsSum).toMoney()
                          : fixedCostsSum.toMoney(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildItemRow({
    required BuildContext context,
    required String title,
    required String name,
    required String powerText,
    required String priceText,
    required IconData icon,
    String? imageUrl,
    String? extraInfo,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Thumbnail
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: 72,
            height: 72,
            color: Colors.black26,
            child: imageUrl != null && imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(icon, color: Colors.white38, size: 32),
                      );
                    },
                  )
                : Center(
                    child: Icon(icon, color: Colors.white38, size: 32),
                  ),
          ),
        ),
        const SizedBox(width: 16),
        // Item Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.bolt, size: 14, color: Colors.white54),
                  const SizedBox(width: 4),
                  Text(
                    powerText,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (extraInfo != null) ...[
                    const SizedBox(width: 12),
                    const Icon(Icons.apps_rounded, size: 14, color: Colors.white54),
                    const SizedBox(width: 4),
                    Text(
                      extraInfo,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                priceText,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpecRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
