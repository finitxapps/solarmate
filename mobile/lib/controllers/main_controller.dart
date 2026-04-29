import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:solar_mate/I18n/messages.dart';
import 'package:solar_mate/configs/app_url_config.dart';
import 'package:solar_mate/models/consumer_model.dart';
import 'package:solar_mate/models/data_model.dart';
import 'package:solar_mate/views/consumers_view.dart';
import 'package:solar_mate/views/floor_number.dart';
import 'package:solar_mate/views/location_view.dart';
import 'package:solar_mate/views/main_view.dart';
import 'package:solar_mate/views/meter_type_view.dart';
import 'package:solar_mate/views/outage_view.dart';
import 'package:solar_mate/views/roof_view.dart';
import 'package:solar_mate/views/select_consumers_view.dart';

class MainController extends GetxController with WidgetsBindingObserver {
  static MainController get to =>
      Get.put<MainController>(MainController(), permanent: true);

  final List<Widget> pages = [
    const ConsumersView(),
    const SelectConsumersView(),
    const RoofView(),
    const LocationView(),
    const MeterTypeView(),
    // const RoofPhotoView(),
    const FloorNumberView(),
    const OutageView(),
  ];
  RxBool showLoading = false.obs;
  RxList<ConsumerItem> consumerList = <ConsumerItem>[].obs;
  final RxInt currentPageIndex = 0.obs;
  final RxList<ConsumerItem> selectedConsumers = <ConsumerItem>[].obs;
  final TextEditingController roofAreaController = TextEditingController();
  final Rx<LatLng> mapPoint = LatLng(35.6892, 51.3890).obs;
  final RxString selectedMeterType = '0'.obs;
  final TextEditingController floorNumberController = TextEditingController();
  final RxInt selectedOutageIndex = 0.obs;

  final ImagePicker picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);

  // Location Status
  final RxString locationStatus = 'loading'.obs;
  MapController? _mapController;

  MapController get mapController {
    _mapController ??= MapController();
    return _mapController!;
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    checkLocationStatus();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _mapController?.dispose();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // وقتی اپلیکیشن resume می‌شود (بعد از بازگشت از تنظیمات)، وضعیت را چک کنیم
      checkLocationStatus();
    }
  }

  Future<void> getConsumers() async {
    http.Response response = await http.get(
      Uri.parse('${AppUrlConfig.appUrl}consumer'),
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      },
    );
    if (response.body.isNotEmpty) {
      print(response.body);
      var decoded = json.decode(response.body);

      if (decoded is List) {
        consumerList.value = List<ConsumerItem>.from(
          decoded.map((x) => ConsumerItem.fromJson(x)),
        );
        Get.off(() => const MainView());
      }
    }
  }

  Future<void> getResults() async {
    showLoading.value = true;
    final String body = DataModel(
      selectedConsumers: selectedConsumers,
      roofArea: roofAreaController.text,
      lat: mapPoint.value.latitude.toString(),
      lng: mapPoint.value.longitude.toString(),
      selectedMeterType: selectedMeterType.value,
      floorNumber: floorNumberController.text,
      selectedOutage: selectedOutageIndex.value.toString(),
    ).toJson().toString();
    print('Json body: $body');
    http.Response response = await http.post(
      Uri.parse('${AppUrlConfig.appUrl}api/input'),
      body: jsonEncode({'sessionId': 0, 'data': body}),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.body.isNotEmpty) {
      print(response.body);
      // var decoded = json.decode(response.body);
      showLoading.value = false;
    }
  }

  void nextPage() {
    if (currentPageIndex.value < pages.length - 1) {
      if (selectedConsumers.isEmpty) {
        Get.snackbar(
          AppMessages.error.tr,
          AppMessages.selectConsumerError.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFB00020),
          colorText: const Color(0xFFFFFFFF),
        );
        return;
      }
      currentPageIndex.value++;
    }
  }

  void previousPage() {
    if (currentPageIndex.value > 0) {
      currentPageIndex.value--;
    }
  }

  void selectMeterType(String? value) {
    selectedMeterType.value = value!;
  }

  Future<void> pickFromGallery() async {
    try {
      final XFile? file = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (file != null) {
        selectedImage.value = File(file.path);
      }
    } catch (e) {
      Get.snackbar("خطا", "دسترسی گالری داده نشد یا لغو شد");
    }
  }

  Future<void> pickFromCamera() async {
    try {
      final XFile? file = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (file != null) {
        selectedImage.value = File(file.path);
      }
    } catch (e) {
      Get.snackbar("خطا", "دسترسی دوربین داده نشد یا لغو شد");
    }
  }

  Future<void> checkLocationStatus() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      locationStatus.value = 'disabled';
    } else if (permission == LocationPermission.denied) {
      locationStatus.value = 'denied';
    } else if (permission == LocationPermission.deniedForever) {
      locationStatus.value = 'deniedForever';
    } else {
      locationStatus.value = 'retrieving';
      await getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      locationStatus.value = 'disabled';
      return;
    }

    if (permission == LocationPermission.denied) {
      locationStatus.value = 'denied';
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      locationStatus.value = 'deniedForever';
      return;
    }

    locationStatus.value = 'retrieving';

    try {
      Position position = await Geolocator.getCurrentPosition();
      final userLatLng = LatLng(position.latitude, position.longitude);
      mapPoint.value = userLatLng;
      mapController.move(userLatLng, 15);
      locationStatus.value = 'success';
    } catch (e) {
      try {
        Position? lastPosition = await Geolocator.getLastKnownPosition();
        if (lastPosition != null) {
          final userLatLng = LatLng(
            lastPosition.latitude,
            lastPosition.longitude,
          );
          mapPoint.value = userLatLng;
          mapController.move(userLatLng, 15);
          locationStatus.value = 'success';
        } else {
          locationStatus.value = 'error';
        }
      } catch (e) {
        locationStatus.value = 'error';
      }
    }
  }

  Future<void> requestLocationPermission() async {
    final status = await Geolocator.requestPermission();
    if (status == LocationPermission.whileInUse ||
        status == LocationPermission.always) {
      locationStatus.value = 'retrieving';
      await getCurrentLocation();
    } else if (status == LocationPermission.denied) {
      locationStatus.value = 'denied';
    } else if (status == LocationPermission.deniedForever) {
      locationStatus.value = 'deniedForever';
    }
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}
