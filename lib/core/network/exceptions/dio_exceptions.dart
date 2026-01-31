import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter_e_commerce/core/network/exceptions/exceptions.dart';
import 'package:dio/dio.dart';

class DioExceptions {
  static AppException map(DioException error) {
    developer.log(
      '┌──────────────────────────────────────────────────────────────',
      name: 'DioException',
    );
    developer.log('│ DioException Type: ${error.type}', name: 'DioException');
    developer.log('│ DioException Error: ${error.error}', name: 'DioException');
    developer.log(
      '│ Response Status Code: ${error.response?.statusCode}',
      name: 'DioException',
    );
    developer.log(
      '│ Response Data: ${error.response?.data}',
      name: 'DioException',
    );

    late AppException exception;

    if (error.error is SocketException) {
      exception = const NetworkException();
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      exception = const TimeoutException();
    } else if (error.type == DioExceptionType.cancel) {
      exception = const CancellationException();
    } else {
      final response = error.response;
      final statusCode = response?.statusCode;
      final data = response?.data;

      String message = _extractMessage(data);

      if (statusCode != null) {
        developer.log('│ Status code: $statusCode', name: 'DioException');
        switch (statusCode) {
          case 400:
            exception = BadRequestException(
              message: message,
              statusCode: statusCode,
              data: data,
            );
            break;
          case 401:
            developer.log('│ UnauthorizedException', name: 'DioException');
            exception = UnauthorizedException(message: message, data: data);
            break;
          case 403:
            developer.log('│ ForbiddenException', name: 'DioException');
            exception = ForbiddenException(message: message, data: data);
            break;
          case 404:
            developer.log('│ NotFoundException', name: 'DioException');
            exception = NotFoundException(message: message, data: data);
            break;
          case 409:
            developer.log('│ ConflictException', name: 'DioException');
            exception = ConflictException(message: message, data: data);
            break;
          case 422:
            developer.log('│ ValidationException', name: 'DioException');
            exception = ValidationException(message: message, data: data);
            break;
          case >= 500:
            developer.log('│ ServerException', name: 'DioException');
            exception = ServerException(
              message: message,
              statusCode: statusCode,
              data: data,
            );
            break;
          default:
            developer.log('│ ClientException', name: 'DioException');
            exception = ClientException(
              message: message,
              statusCode: statusCode,
              data: data,
            );
            break;
        }
      } else {
        developer.log('Returning UnknownException');
        exception = UnknownException(message: message);
      }
    }

    developer.log(
      '└──────────────────────────────────────────────────────────────',
      name: 'DioException',
    );

    return exception;
  }

  static String _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] ??
          data['error'] ??
          data['detail'] ??
          'Something went wrong';
    }

    if (data is String && data.isNotEmpty) {
      return data;
    }

    return 'Unexpected error occurred';
  }
}
