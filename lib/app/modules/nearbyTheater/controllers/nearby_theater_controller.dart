import 'dart:convert';
import 'dart:io';

import 'package:cinema/app/base/base_controller.dart';
import 'package:cinema/app/data/response/nearby_theater_response.dart';
import 'package:cinema/app/modules/home/controllers/home_controller.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../api/api_client/location_dio_client.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyTheaterController extends BaseController {
  bool showLoading = false;
  GoogleMapController? mapController;

  final LocationDioClient dioClient = Get.find();
  List<TheaterItem> theaterList = [];
  Set<Marker> markers = {};
  String _mapStyle = '';

  @override
  onInit() async {
    super.onInit();
    if (sharedController.userLocation == null) {
      await Get.find<HomeController>().getCurrentLocation();
      update();
    }
  }

  @override
  onReady() async {
    if (sharedController.userLocation != null) {
      _moveCameraToPosition(sharedController.userLocation!);

      await getNearbyTheaterData();
    }
  }

  getNearbyTheaterData() async {
    if (sharedController.userLocation == null) return;
    showLoading = true;
    update();
    NearbyTheaterResponse? nearbyTheaterResponse = await dioClient
        .getNearbyTheater(userLocation: sharedController.userLocation);
    theaterList = nearbyTheaterResponse?.results ?? [];
    if (theaterList.isNotEmpty) setLocationMarkers();
    showLoading = false;
    update();
  }

  Future<void> _moveCameraToPosition(Position position) async {
    final GoogleMapController? controller = mapController;
    if (controller != null) {
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          14,
        ),
      );
    }
  }

  void setLocationMarkers() {
    markers.clear();
    theaterList.forEach((theater) {
      markers.add(
        Marker(
          markerId: MarkerId(theater.placeId ?? ""),
          position: LatLng(
            theater.geometry?.location?.lat?.toDouble() ?? 23.01,
            theater.geometry?.location?.lng?.toDouble() ?? 90.01,
          ),
          infoWindow: InfoWindow(
            title: theater.name ?? 'name',
            snippet: theater.vicinity ?? "location",
          ),
        ),
      );
    });
  }
}
