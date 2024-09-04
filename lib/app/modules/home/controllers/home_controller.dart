import 'package:cinema/app/base/base_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  @override
  onInit() async {
    super.onInit();
    getCurrentLocation();
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return sharedController.userLocation =
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  int selectedIndex = 0;
  void changeIndex(int value) {
    selectedIndex = value;
    update();
  }
}
