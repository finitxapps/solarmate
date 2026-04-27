import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import 'package:solar_mate/views/main_view.dart';

class SplashController extends GetxController {
  static SplashController get to =>
      Get.put<SplashController>(SplashController());

  Future<void> getCunsomers() async {
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const MainView());
    });

    //   http.Response response = await http.get(
    //     Uri.parse('${AppUrlConfig.appUrl}cunsomers'),
    //   );

    //   if (response.body.isNotEmpty) {
    //     if (json.decode(response.body)['status'] == "OK") {
    //       configModel.value = configModelFromJson(response.body);
    //     } else {
    //       snackBarWidget(
    //         messageText: json.decode(response.body)['error_msg'],
    //         type: SnackBarWidgetType.failure,
    //       );
    //     }
    //   }
  }
}
