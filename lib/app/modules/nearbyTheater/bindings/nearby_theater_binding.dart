import 'package:get/get.dart';

import '../controllers/nearby_theater_controller.dart';

class NearbyTheaterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NearbyTheaterController>(
      () => NearbyTheaterController(),
    );
  }
}
