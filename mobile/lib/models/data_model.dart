import 'dart:convert';

import 'package:solar_mate/models/consumer_model.dart';

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  List<ConsumerItem> selectedConsumers;
  String roofArea;
  String lat;
  String lng;
  String selectedMeterType;
  String floorNumber;
  String selectedOutage;
  String? batteryHours;

  DataModel({
    required this.selectedConsumers,
    required this.roofArea,
    required this.lat,
    required this.lng,
    required this.selectedMeterType,
    required this.floorNumber,
    required this.selectedOutage,
    this.batteryHours,
  });

  Map<String, dynamic> toJson() => {
    "selectedConsumers": selectedConsumers,
    "roofArea": roofArea,
    "lat": lat,
    "lng": lng,
    "selectedMeterType": selectedMeterType,
    "floorNumber": floorNumber,
    "selectedOutage": selectedOutage,
    if (batteryHours != null) "batteryHours": batteryHours,
  };
}
