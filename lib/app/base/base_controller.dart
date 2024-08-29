import 'package:cinema/app/base/shared_controller.dart';

import 'package:get/get.dart';

import '../local_storage/local_storage_controller.dart';

class BaseController extends GetxController {
  final LocalStorage localStorage = Get.find();
  final SharedController sharedController = Get.find();
  bool loader = false;
}
