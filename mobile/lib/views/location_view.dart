import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:solar_mate/I18n/messages.dart';
import 'package:solar_mate/controllers/main_controller.dart';
import 'package:solar_mate/widgets/colors_widget.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppMessages.location.tr,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    AppMessages.locationTip.tr,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white54,
                    ),
                  ),
                ],
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
          // Status Message Section
          _buildLocationStatusWidget(),
          SizedBox(height: 20),
          SizedBox(
            height: 520,
            child: FlutterMap(
              mapController: MainController.to.mapController,
              options: MapOptions(
                initialCenter: MainController.to.mapPoint.value,
                initialZoom: 15,
                onTap: (tapPosition, point) {
                  MainController.to.mapPoint.value = point;
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://map.ir/shiveh/xyz/1.0.0/Shiveh:Shiveh@EPSG:3857@png/{z}/{x}/{y}.png"
                      "?x-api-key=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjNkNjkzZWFmMmQxYjgyYWU5MDNjNDdmZjFkYzQwZjMyZmZiZWM1NjZjNGVhMDc0YTFjNDhhZGU1N2Q0NzEzZTdiOWY3OGRmOGI1ZjYzZTQzIn0.eyJhdWQiOiIyNjg3MiIsImp0aSI6IjNkNjkzZWFmMmQxYjgyYWU5MDNjNDdmZjFkYzQwZjMyZmZiZWM1NjZjNGVhMDc0YTFjNDhhZGU1N2Q0NzEzZTdiOWY3OGRmOGI1ZjYzZTQzIiwiaWF0IjoxNzEyNDc3NzIzLCJuYmYiOjE3MTI0Nzc3MjMsImV4cCI6MTcxNTA2OTcyMywic3ViIjoiIiwic2NvcGVzIjpbImJhc2ljIl19.qs65qqPbqicYGK48r70twIWBkVVTZYNCyJXW1fr8cJpOnh4LXTIh2jB-4g-5gevG55iQGlmpCQirGh1xQtQ_H7_Y2unqJr5lbm0OpLJFnkJyrPA2k6mIqhyevJwzAzmRu1hQC0_YNisY2tj-blu0SR_Ossq-XSR7I6qbvShdSLd3s9_5MCFW7dTcdnlr5ySz6X8L3rVtqS_TbEU3rKPpdUAAO0TsMjeAODcwKP9IbAVnRTCO7anrQAFDqp2IF-LWhjQklgmI0MdrRPgPjJ2ACVB3vnaze0SrNUxheV6BfN-fNVkeKMIsPDmBLYW4YaWUd-1Pv6m2EuNBsitqSk570w",
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: MainController.to.mapPoint.value,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
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

  Widget _buildLocationStatusWidget() {
    return Obx(() {
      if (MainController.to.locationStatus.value == 'disabled') {
        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.1),
            border: Border.all(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'لوکیشن خاموش است',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => MainController.to.openLocationSettings(),
                icon: Icon(Icons.settings),
                label: Text('رفتن به تنظیمات'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      } else if (MainController.to.locationStatus.value == 'denied') {
        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.1),
            border: Border.all(color: Colors.orange, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'دسترسی به لوکیشن رد شد',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => MainController.to.requestLocationPermission(),
                icon: Icon(Icons.check_circle),
                label: Text('درخواست دسترسی'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      } else if (MainController.to.locationStatus.value == 'deniedForever') {
        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.1),
            border: Border.all(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'دسترسی به لوکیشن دائمی رد شد',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => MainController.to.openAppSettings(),
                icon: Icon(Icons.settings),
                label: Text('رفتن به تنظیمات اپلیکیشن'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      } else if (MainController.to.locationStatus.value == 'retrieving') {
        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            border: Border.all(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              SizedBox(width: 12),
              Text(
                'در حال دریافت موقعیت شما...',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      } else if (MainController.to.locationStatus.value == 'error') {
        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.1),
            border: Border.all(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'خطا در دریافت موقعیت',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => MainController.to.getCurrentLocation(),
                icon: Icon(Icons.refresh),
                label: Text('تلاش دوباره'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      } else {
        return SizedBox();
      }
    });
  }
}
