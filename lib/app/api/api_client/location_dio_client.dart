import 'dart:convert';
import 'dart:io';

import 'package:cinema/app/data/response/nearby_theater_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as g;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../common/app_constants.dart';
import '../../utils/utility.dart';
import 'package:geolocator/geolocator.dart';

class LocationDioClient extends g.GetxService {
  late Dio _dio;

  Map<String, String?>? _header;
  Future<LocationDioClient> init() async {
    _header = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.userAgentHeader: getPlatformName(),
      HttpHeaders.acceptLanguageHeader: "en",
      HttpHeaders.contentLanguageHeader: "en",
    };

    _dio = Dio(BaseOptions(
      headers: _header,
      connectTimeout: const Duration(minutes: 3),
      receiveTimeout: const Duration(minutes: 3),
    ));

    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }
    return this;
  }

  Future<NearbyTheaterResponse?> getNearbyTheater(
      {Position? userLocation}) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=23.8041,90.4152&radius=5000&type=movie_theater&key=${AppConstants.mapKey}';
    // final String url =
    //        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${userLocation?.latitude},${userLocation?.longitude}&radius=5000&type=movie_theater&key=${AppConstants.mapKey}';

    final response = await _dio.get(
      url,
    );

    if (response.statusCode == 200 && response.data != null) {
      return NearbyTheaterResponse.fromJson(response.data);
    } else {
      showDelightToast(
          title: "Failed", subtitle: "Failed to load nearby theaters!");
    }
    return null;
  }
}
