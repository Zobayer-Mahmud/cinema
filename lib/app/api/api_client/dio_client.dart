import 'dart:io';
import 'package:cinema/app/common/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as g;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../local_storage/local_storage_controller.dart';
import '../../local_storage/local_storage_key.dart';
import '../../utils/enums/toast_type.dart';
import '../../utils/utility.dart';
import 'api_response.dart';

class DioClient extends g.GetxService {
  late Dio _dio;
  Map<String, String?>? _header;

  Future<DioClient> init() async {
    _header = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.userAgentHeader: getPlatformName(),
      if (LocalStorage().getData(LocalStorageKey.TOKEN) != null)
        HttpHeaders.authorizationHeader:
            'Bearer ${LocalStorage().getData(LocalStorageKey.TOKEN)}',
    };

    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      // baseUrl: AppConstants.devBaseUrl,
      headers: _header,
      connectTimeout: const Duration(minutes: 3),
      receiveTimeout: const Duration(minutes: 3),
    ));

    /// Need to intercept all request for language
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          updateLanguage();
          _dio.options.headers = _header;
          handler.next(options);
        },
      ),
    );

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

  updateLanguage() {
    _dio.options.headers = _header;
    return _header;
  }

  updateAuthToken({required String? token}) {
    print("updateAuthToken");
    if (token != null) {
      _header?[HttpHeaders.authorizationHeader] = 'Bearer $token';
      _dio.options.headers = _header;
    } else {
      _header?[HttpHeaders.authorizationHeader] = null;
      _dio.options.headers = _header;
    }
  }

  clearAuthorization() {
    _header
        ?.removeWhere((key, value) => key == HttpHeaders.authorizationHeader);
    _dio.options.headers = _header;
  }

  Future<ApiResponse> get(
      {required String endpoint, Map<String, dynamic>? queryParams}) async {
    queryParams?.removeWhere((key, value) => value == "null" || value == null);
    try {
      print("Token: ${_header?['authorization']}");
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e is DioException) {
        if (getApiErrorMessage(e) != null) {
          showDelightToast(
              title: 'Sorry',
              subtitle: getApiErrorMessage(e)!,
              type: ToastType.fail,
              duration: const Duration(seconds: 3));
        }
      }
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> post({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
  }) async {
    queryParams?.removeWhere((key, value) => value == "null" || value == null);
    data?.removeWhere((key, value) => value == "null" || value == null);
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParams,
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e is DioException) {
        if (getApiErrorMessage(e) != null) {
          showDelightToast(
              title: 'Sorry',
              subtitle: getApiErrorMessage(e)!,
              duration: const Duration(seconds: 3),
              type: ToastType.fail);
        }
      }
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> put(
      {required String endpoint, Map<String, dynamic>? data}) async {
    // if (showApiLoading == true)

    // data?.removeWhere(
    //     (key, value) => value == "null" || value == null );

    try {
      final response = await _dio.put(
        endpoint,
        data: data,
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e is DioException) {
        if (getApiErrorMessage(e) != null) {
          showDelightToast(
              title: 'Sorry',
              subtitle: getApiErrorMessage(e)!,
              duration: const Duration(seconds: 3),
              type: ToastType.fail);
        }
      }
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> requestWithFile(
      {required String endpoint,
      // Map<String, dynamic>? body,
      required List<MapEntry<String, File>> files,
      int? index}) async {
    try {
      Map<String, dynamic>? map;
      if (index != null) {
        map = {"index": index};
      }
      FormData formData = FormData.fromMap(map ?? {});

      // formData.
      for (var element in files) {
        formData.files.add(MapEntry(
            element.key,
            MultipartFile.fromFileSync(element.value.path,
                filename: element.value.path.split("/").last)));
      }
      final response = await _dio.post(endpoint, data: formData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e is DioException) {
        if (getApiErrorMessage(e) != null) {
          showDelightToast(
              title: 'Sorry',
              subtitle: getApiErrorMessage(e)!,
              duration: const Duration(seconds: 3),
              type: ToastType.fail);
        }
      }
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> patch(
      {required String endpoint,
      Map<String, dynamic>? data,
      bool? showApiLoading}) async {
    data?.removeWhere((key, value) => value == "null" || value == null);
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e is DioException) {
        if (getApiErrorMessage(e) != null) {
          showDelightToast(
              title: 'Sorry',
              subtitle: getApiErrorMessage(e)!,
              duration: const Duration(seconds: 3),
              type: ToastType.fail);
        }
      }
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> delete(
      {required String endpoint,
      Map<String, dynamic>? data,
      bool? showApiLoading}) async {
    data?.removeWhere((key, value) => value == "null" || value == null);
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e is DioException) {
        if (getApiErrorMessage(e) != null) {
          showDelightToast(
              title: 'Sorry',
              subtitle: getApiErrorMessage(e)!,
              duration: const Duration(seconds: 3),
              type: ToastType.fail);
        }
      }

      return ApiResponse.withError(e);
    }
  }

  String? getApiErrorMessage(DioException error) {
    print(error.type);
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection Timeout';
      case DioExceptionType.sendTimeout:
        return 'Connection Timeout';
      case DioExceptionType.receiveTimeout:
        return 'Connection Timeout';
      case DioExceptionType.badResponse:
        if (error.response != null && error.response?.statusCode != null) {
          if (error.response?.statusCode == 401) {
            g.Get.find<LocalStorage>().clearStorage();
            return null;
          }
          if (error.response?.statusCode == 470) {
            // g.Get.offAllNamed(Routes.PROFILE_DEACTIVATED);
          }
          return error.response?.data['message'];
        } else {
          return 'Bad Request';
        }
      case DioExceptionType.cancel:
        return 'Request Cancelled';
      default:
        // return "Something went wrong, try again";
        return null;
    }
  }
}
