import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'dio_exception.dart';



class CustomException implements Exception {
  final String message;
  final int? statusCode;
  final ExceptionType exceptionType;

  CustomException({
    int? statusCode,
    required this.message,
    this.exceptionType = ExceptionType.ApiException,
  }) : statusCode = statusCode ?? 500;

  factory CustomException.fromDioException(Exception error) {
    try {
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.cancel:
            return CustomException(
              exceptionType: ExceptionType.CancelException,
              statusCode: error.response?.statusCode,
              message: 'Request cancelled prematurely'.tr,
            );
          case DioErrorType.connectionTimeout:
            return CustomException(
              exceptionType: ExceptionType.ConnectTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Connection not established'.tr,
            );
          case DioErrorType.sendTimeout:
            return CustomException(
              exceptionType: ExceptionType.SendTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Failed to send'.tr,
            );
          case DioErrorType.receiveTimeout:
            return CustomException(
              exceptionType: ExceptionType.ReceiveTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Failed to receive'.tr,
            );

          case DioErrorType.badCertificate:
            return CustomException(
              exceptionType: ExceptionType.UnrecognizedException,
              statusCode: error.response?.statusCode,
              message: 'Bad certificate exception'.tr,
            );
          case DioErrorType.badResponse:
            return CustomException(
              exceptionType: ExceptionType.UnrecognizedException,
              statusCode: error.response?.statusCode,
              message: 'Bad response exception'.tr,
            );

          case DioErrorType.connectionError:
            return CustomException(
              exceptionType: ExceptionType.ConnectionError,
              statusCode: error.response?.statusCode,
              message: 'Connection error exception'.tr,
            );

          case DioErrorType.unknown:
            return CustomException(
              exceptionType: ExceptionType.Unknown,
              statusCode: error.response?.statusCode,
              message: 'Unknown exception'.tr,
            );
        }
      } else {
        return CustomException(
          exceptionType: ExceptionType.UnrecognizedException,
          message: 'Error unrecognized'.tr,
        );
      }
    } on FormatException catch (e) {
      return CustomException(
        exceptionType: ExceptionType.FormatException,
        message: e.message,
      );
    } on Exception catch (_) {
      return CustomException(
        exceptionType: ExceptionType.UnrecognizedException,
        message: 'Error unrecognized'.tr,
      );
    }
  }

  factory CustomException.fromParsingException(Exception error) {
    // TODO(arafaysaleem): add logging to print stack trace
    debugPrint('$error');
    return CustomException(
      exceptionType: ExceptionType.SerializationException,
      message: 'Failed to parse network response to model or vice versa'.tr,
    );
  }
}
