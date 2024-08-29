import 'package:dio/dio.dart';
import 'package:get/get.dart';


import '../api/api_client/api_response.dart';
import '../api/api_client/dio_client.dart';
import '../local_storage/local_storage_controller.dart';
import 'shared_controller.dart';

class BaseApiService extends GetxService {
  SharedController sharedController = Get.find();
  final DioClient dioClient = Get.find();
  final LocalStorage localStorage = Get.find();
  final dioWithoutToken = Dio();

  dynamic handleResponse(dynamic returnType, ApiResponse apiResponse) {
    if (apiResponse.success && apiResponse.response != null) {
      try {
        return returnType.fromMap(apiResponse.response?.data['data']);
      } catch (e) {
        sharedController.logger.e('Parse Error', error: e);
        return null;
      }
    } else {
      sharedController.logger.e('Api Error', error: apiResponse.error);
      return null;
    }
  }
}
