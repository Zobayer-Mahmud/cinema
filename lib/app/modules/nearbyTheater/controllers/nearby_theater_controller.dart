import 'dart:convert';
import 'dart:io';

import 'package:cinema/app/base/base_controller.dart';
import 'package:cinema/app/common/app_constants.dart';
import 'package:cinema/app/data/response/nearby_theater_response.dart';
import 'package:cinema/app/modules/home/controllers/home_controller.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../api/api_client/location_dio_client.dart';
import '../../../utils/utility.dart';

class NearbyTheaterController extends BaseController {
  Position? userLocation;
  late Dio _dio;
  Map<String, String?>? _header;
  bool showLoading = false;

  final LocationDioClient dioClient = Get.find();
  List<TheaterItem> theaterList = [];

  @override
  onInit() async {
    super.onInit();
    if (sharedController.userLocation == null) {
      await Get.find<HomeController>().getCurrentLocation();
    }
  }

  @override
  onReady() async {
    if (sharedController.userLocation != null) await getNearbyTheaterData();
  }

  getNearbyTheaterData() async {
    showLoading = true;
    update();
    NearbyTheaterResponse? nearbyTheaterResponse =
        await dioClient.getNearbyTheater(userLocation: userLocation);
    theaterList = nearbyTheaterResponse?.results ?? [];
    showLoading = false;
    update();
  }
}
