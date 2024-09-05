import 'package:cinema/app/base/base_controller.dart';
import 'package:cinema/app/modules/nearbyTheater/controllers/nearby_theater_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  @override
  onInit() async {
    super.onInit();
    await getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showLocationServicesDialog();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showPermissionDeniedDialog();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await _showPermissionPermanentlyDeniedDialog();
      return;
    }

    sharedController.userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (Get.isRegistered<NearbyTheaterController>()) {
      await Get.find<NearbyTheaterController>().getNearbyTheaterData();
    }
    return;
  }

  void _showPermissionDeniedDialog() {
    ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
      content: Text('Location permissions are denied.'),
    ));
  }

  // Show a dialog if location permission is permanently denied
  _showPermissionPermanentlyDeniedDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text(
          'Location Permissions Denied',
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'Location permissions are permanently denied. Please enable them in settings.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openAppSettings();
              await _checkLocationServiceEnabled();
            },
            child: const Text(
              'Open Settings',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  _showLocationServicesDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text(
          'Location Services Disabled',
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'Please enable GPS to allow the app to access your current location.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openLocationSettings();

              await _checkLocationServiceEnabled();
            },
            child: const Text(
              'Enable GPS',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  _checkLocationServiceEnabled() async {
    const duration = Duration(seconds: 2); // Check every 2 seconds
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // Polling logic to check if GPS is enabled
    if (!serviceEnabled) {
      print('Waiting for GPS to be enabled...');
      Future.delayed(
          duration, _checkLocationServiceEnabled); // Repeat after 2 seconds
    } else {
      await getCurrentLocation(); // Call your method to fetch the location
    }
  }

  int selectedIndex = 0;
  void changeIndex(int value) {
    selectedIndex = value;
    update();
  }
}
