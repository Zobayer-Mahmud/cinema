import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api/api_client/dio_client.dart';


class LocalStorage extends GetxController {
  GetStorage box = GetStorage();

  saveData(String key, dynamic value) => box.write(key, value);

  getData(String key) => box.read(key);

  clearStorage() {
    box.erase();
    Get.find<DioClient>().updateAuthToken(token: null);
  }
}
