import 'dart:convert';

ConsumerModel consumerModelFromJson(String str) =>
    ConsumerModel.fromJson(json.decode(str));

String consumerModelToJson(ConsumerModel data) => json.encode(data.toJson());

class ConsumerModel {
  List<ConsumerItem> list;

  ConsumerModel({required this.list});

  factory ConsumerModel.fromJson(List<dynamic> json) => ConsumerModel(
    list: List<ConsumerItem>.from(json.map((x) => ConsumerItem.fromJson(x))),
  );

  List<dynamic> toJson() => List<dynamic>.from(list.map((x) => x.toJson()));
}

class ConsumerItem {
  String id;
  String type;
  int normalWattage;
  int surgeWattage;
  bool? inverter;
  int count = 1;
  int concurrentCount = 0;
  bool isConcurrent = false;
  bool amperControl;
  Map<String, dynamic>? features;

  ConsumerItem({
    required this.id,
    required this.type,
    required this.normalWattage,
    required this.surgeWattage,
    required this.inverter,
    required this.amperControl,
    required this.features,
  });

  factory ConsumerItem.fromJson(Map<String, dynamic> json) => ConsumerItem(
    id: json["id"],
    type: json["type"],
    normalWattage: json["normalWattage"],
    surgeWattage: json["surgeWattage"],
    inverter: json["inverter"],
    amperControl: json["amperControl"],
    features: json["features"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "normalWattage": normalWattage,
    "surgeWattage": surgeWattage,
    "inverter": inverter,
    "amperControl": amperControl,
    "features": features,
  };
}
