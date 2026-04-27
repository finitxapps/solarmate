import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:solar_mate/I18n/messages.dart';
import 'package:solar_mate/controllers/main_controller.dart';
import 'package:solar_mate/widgets/colors_widget.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  Future<void> _getCurrentLocation(MapController mapController) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      await Geolocator.openLocationSettings();

      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    final userLatLng = LatLng(position.latitude, position.longitude);
    MainController.to.mapPoint.value = userLatLng;
    mapController.move(userLatLng, 15);
  }

  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController();
    _getCurrentLocation(mapController);
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
          TextField(
            readOnly: true,
            canRequestFocus: false,
            controller: TextEditingController(
              text: MainController.to.mapPoint.value.latitude.toString(),
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppMessages.latitude.tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            readOnly: true,
            canRequestFocus: false,
            controller: TextEditingController(
              text: MainController.to.mapPoint.value.longitude.toString(),
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppMessages.longitude.tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),

          const SizedBox(height: 20),
          SizedBox(
            height: 390,
            child: FlutterMap(
              mapController: mapController,
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
}
