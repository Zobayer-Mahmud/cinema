import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/api/api_client/dio_client.dart';
import 'app/api/service/movie_service.dart';
import 'app/base/shared_controller.dart';
import 'app/local_storage/local_storage_controller.dart';

class ServiceLocator {
  initializeApp() async {
    await GetStorage.init();
    Get.put<LocalStorage>(LocalStorage());
    Get.put<SharedController>(SharedController());
    await Hive.initFlutter();
    await Hive.openBox('favorites');
    await Hive.openBox('preferences');
    //register Services Here . .
    await Get.putAsync<DioClient>(() => DioClient().init());
    await Get.putAsync<MovieService>(() async => MovieService());
  }
}
