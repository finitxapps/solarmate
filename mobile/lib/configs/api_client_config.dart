import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:solar_mate/configs/app_url_config.dart';

RxBool showLoading = false.obs;
RxBool isWillPopScope = false.obs;

enum HttpMethod { get, post, put, delete }

class ApiClient {
  Map<String, String> baseHeader({bool needToken = true}) {
    return {
      'Content-Type': 'application/json;charset=UTF-8',
      'Accept': 'application/json',
      if (needToken) 'Authorization': 'Bearer ${GetStorage().read('token')}',
    };
  }

  Future<http.Response> setHttpMethode({
    required String urlPath,
    required HttpMethod httpMethod,
    Map<String, dynamic>? body,
    bool needToken = true,
  }) async {
    if (httpMethod == HttpMethod.get) {
      return await http.get(
        Uri.parse(AppUrlConfig.appUrl + urlPath),
        headers: baseHeader(needToken: needToken),
      );
    } else if (httpMethod == HttpMethod.post) {
      return await http.post(
        Uri.parse(AppUrlConfig.appUrl + urlPath),
        body: json.encode(body),
        headers: baseHeader(needToken: needToken),
      );
    } else if (httpMethod == HttpMethod.put) {
      return await http.put(
        Uri.parse(AppUrlConfig.appUrl + urlPath),
        body: json.encode(body),
        headers: baseHeader(needToken: needToken),
      );
    } else {
      return await http.delete(
        Uri.parse(AppUrlConfig.appUrl + urlPath),
        body: json.encode(body),
        headers: baseHeader(needToken: needToken),
      );
    }
  }

  Future<http.Response> httpRequest({
    required String urlPath,
    required HttpMethod httpMethod,
    Map<String, dynamic>? body,
    bool needToken = true,
  }) async {
    late http.Response response;
    try {
      response =
          await setHttpMethode(
            httpMethod: httpMethod,
            urlPath: urlPath,
            body: body,
            needToken: needToken,
          ).timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              return http.Response(
                '{"isSuccess": false,"message": "خطایی در برقراری ارتباط به وجود آمده است لطفا دقایقی دیگر مجددا تلاش کنید.","statusCode": 2}',
                500,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              );
            },
          );
      if (response.statusCode == 401) {
        final bool result = await GetStorage().read('token');
        if (result) {
          response =
              await setHttpMethode(
                httpMethod: httpMethod,
                urlPath: urlPath,
                body: body,
                needToken: needToken,
              ).timeout(
                const Duration(seconds: 30),
                onTimeout: () {
                  return http.Response(
                    '{"isSuccess": false,"message": "خطایی در برقراری ارتباط به وجود آمده است لطفا دقایقی دیگر مجددا تلاش کنید.","statusCode": 2}',
                    500,
                    headers: {
                      HttpHeaders.contentTypeHeader:
                          'application/json; charset=utf-8',
                    },
                  );
                },
              );
        }
      }
      return response;
    } catch (e) {
      if (e.toString().contains('Failed host lookup:') ||
          e.toString().contains('Connection failed')) {
        return http.Response(
          '{"isSuccess": false,"message": "دسترسی به اینترنت وجود ندارد.","statusCode": 2}',
          500,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        );
      }
      return http.Response(
        '{"isSuccess": false,"message": "خطایی در سرور رخ داده است.","statusCode": 2}',
        500,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      );
    }
  }

  Future<String> httpResponse({
    required String urlPath,
    required HttpMethod httpMethod,
    Map<String, dynamic>? body,
    bool needToken = true,
    bool needLoading = false,
  }) async {
    showLoading.value = needLoading;
    isWillPopScope.value = false;
    // await Future.delayed(const Duration(seconds: 4));
    debugPrint('url: $urlPath');
    final http.Response response = await httpRequest(
      urlPath: urlPath,
      needToken: needToken,
      httpMethod: httpMethod,
      body: body,
    );
    debugPrint('response: ${response.body}');

    if (response.statusCode != 401) {
      final String decodeUtf8 = utf8.decode(response.bodyBytes);
      // final BaseDataModel result = baseDataModelFromJson(decodeUtf8);
      // if (result.isSuccess) {
      //   showLoading.value = false;
      //   isWillPopScope.value = true;
      //   return decodeUtf8;
      // } else {
      //   debugPrint('Error: $urlPath');
      //   snackBarWidget(
      //     messageText: result.message,
      //     type: SnackBarWidgetType.failure,
      //   );
      //   isWillPopScope.value = true;
      //   showLoading.value = false;
      //   return '';
      // }
      return '';
    } else {
      await GetStorage().remove('token');
      await GetStorage().remove('refreshToken');
      await GetStorage().remove('vehicleId');
      // FirebaseMessaging.instance.deleteToken();
      Get.offAllNamed('/CheckUsernameView');
      isWillPopScope.value = true;
      showLoading.value = false;
      // EasyLoading.dismiss();
      return '';
    }
  }
}
