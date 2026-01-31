import 'dart:developer' as developer;
import 'package:dio/dio.dart';

/// Interceptor for logging HTTP requests and responses
class LoggingInterceptor extends Interceptor {
  final bool logRequest;
  final bool logResponse;
  final bool logError;

  LoggingInterceptor({
    this.logRequest = true,
    this.logResponse = true,
    this.logError = true,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (logRequest) {
      developer.log(
        '┌──────────────────────────────────────────────────────────────',
        name: 'DIO',
      );
      developer.log('│ REQUEST: ${options.method} ${options.uri}', name: 'DIO');
      developer.log('│ Headers: ${options.headers}', name: 'DIO');
      if (options.queryParameters.isNotEmpty) {
        developer.log(
          '│ Query Parameters: ${options.queryParameters}',
          name: 'DIO',
        );
      }
      if (options.data != null) {
        developer.log('│ Body: ${options.data}', name: 'DIO');
      }
      developer.log(
        '└──────────────────────────────────────────────────────────────',
        name: 'DIO',
      );
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (logResponse) {
      developer.log(
        '┌──────────────────────────────────────────────────────────────',
        name: 'DIO',
      );
      developer.log(
        '│ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}',
        name: 'DIO',
      );
      developer.log('│ Headers: ${response.headers}', name: 'DIO');
      developer.log('│ Body: ${response.data}', name: 'DIO');
      developer.log(
        '└──────────────────────────────────────────────────────────────',
        name: 'DIO',
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (logError) {
      developer.log(
        '┌──────────────────────────────────────────────────────────────',
        name: 'DIO',
      );
      developer.log(
        '│ ERROR: ${err.type} ${err.requestOptions.uri}',
        name: 'DIO',
      );
      // developer.log('│ Message: ${err.message}', name: 'DIO');
      if (err.response != null) {
        developer.log(
          '│ Status Code: ${err.response?.statusCode}',
          name: 'DIO',
        );
        developer.log('│ Response: ${err.response?.data}', name: 'DIO');
      }
      developer.log(
        '└──────────────────────────────────────────────────────────────',
        name: 'DIO',
      );
    }
    super.onError(err, handler);
  }
}
