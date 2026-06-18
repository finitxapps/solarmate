import 'dart:convert';

ResultModel resultFromJson(String str) {
  final decoded = json.decode(str);
  if (decoded is List) {
    return ResultModel.fromJson(decoded.first);
  }
  return ResultModel.fromJson(decoded);
}

String resultToJson(ResultModel data) => json.encode(data.toJson());

class ResultModel {
  List<PackageModel> packages;
  // List<SuggestionModel> suggestions;
  List<OtherCostModel> otherCosts;

  ResultModel({
    required this.packages,
    // required this.suggestions,
    required this.otherCosts,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
    packages: List<PackageModel>.from(
      json["packages"].map((x) => PackageModel.fromJson(x)),
    ),
    // suggestions: List<SuggestionModel>.from(
    //     json["suggestions"].map((x) => SuggestionModel.fromJson(x))),
    otherCosts: List<OtherCostModel>.from(
      json["otherCosts"].map((x) => OtherCostModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
    // "suggestions": List<dynamic>.from(suggestions.map((x) => x.toJson())),
    "otherCosts": List<dynamic>.from(otherCosts.map((x) => x.toJson())),
  };
}

class PackageModel {
  InverterModel inverter;
  int inverterCount;
  PanelModel panel;
  int panelCount;
  int totalPrice;
  String type;
  BatteryConfigModel? batteryConfig;

  PackageModel({
    required this.inverter,
    required this.inverterCount,
    required this.panel,
    required this.panelCount,
    required this.totalPrice,
    required this.type,
    this.batteryConfig,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
    inverter: InverterModel.fromJson(json["inverter"]),
    inverterCount: json["inverterCount"] ?? 1,
    panel: PanelModel.fromJson(json["panel"]),
    panelCount: json["panelCount"],
    totalPrice: json["totalPrice"],
    type: json["type"],
    batteryConfig: json["batteryConfig"] != null
        ? BatteryConfigModel.fromJson(json["batteryConfig"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "inverter": inverter.toJson(),
    "inverterCount": inverterCount,
    "panel": panel.toJson(),
    "panelCount": panelCount,
    "totalPrice": totalPrice,
    "type": type,
    "batteryConfig": batteryConfig?.toJson(),
  };
}

class BatteryConfigModel {
  String name;
  int capacityWh;
  int count;
  int totalCost;
  int price;
  String? image;

  BatteryConfigModel({
    required this.name,
    required this.capacityWh,
    required this.count,
    required this.totalCost,
    required this.price,
    this.image,
  });

  factory BatteryConfigModel.fromJson(Map<String, dynamic> json) {
    final countVal = json["count"] ?? 1;
    final totalCostVal = json["totalCost"] ?? json["price"] ?? 0;
    final priceVal = json["price"] ?? (countVal > 0 ? (totalCostVal ~/ countVal) : 0);

    return BatteryConfigModel(
      name: json["brand"] ?? json["name"] ?? 'Battery',
      capacityWh: json["capacityWh"] ?? json["capacity"] ?? 0,
      count: countVal,
      totalCost: totalCostVal,
      price: priceVal,
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
    "brand": name,
    "capacityWh": capacityWh,
    "count": count,
    "totalCost": totalCost,
    "price": price,
    "image": image,
  };
}

class InverterModel {
  String name;
  int maxPower;
  int price;
  String? image;
  bool threePhase;

  InverterModel({
    required this.name,
    required this.maxPower,
    required this.price,
    required this.threePhase,
    this.image,
  });

  factory InverterModel.fromJson(Map<String, dynamic> json) => InverterModel(
    name: json["brand"] ?? json["name"] ?? '',
    maxPower: json["power"] ?? json["maxPower"] ?? 0,
    price: json["price"] ?? 0,
    image: json["image"],
    threePhase: json["three_phase"] ?? json["threePhase"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "maxPower": maxPower,
    "price": price,
    "image": image,
    "three_phase": threePhase,
  };
}

class PanelModel {
  String name;
  int power;
  int price;
  String? image;

  PanelModel({
    required this.name,
    required this.power,
    required this.price,
    this.image,
  });

  factory PanelModel.fromJson(Map<String, dynamic> json) => PanelModel(
    name: json["brand"] ?? json["name"] ?? '',
    power: json["wattage"] ?? json["power"] ?? 0,
    price: json["price"] ?? 0,
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "power": power,
    "price": price,
    "image": image,
  };
}

class OtherCostModel {
  String name;
  int price;
  String description;
  int id;
  DateTime createdAt;
  DateTime updatedAt;

  OtherCostModel({
    required this.name,
    required this.price,
    required this.description,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OtherCostModel.fromJson(Map<String, dynamic> json) => OtherCostModel(
    name: json["name"],
    price: json["price"],
    description: json["description"],
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "description": description,
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
