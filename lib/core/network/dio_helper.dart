import 'package:dio/dio.dart';
import 'package:flutter_e_commerce/core/network/dio_client.dart';
import 'package:flutter_e_commerce/core/network/exceptions/dio_exceptions.dart';
import 'package:flutter_e_commerce/core/network/exceptions/exceptions.dart';

enum ApiMethod { get, post, put, delete, patch }

class ApiRequest {
  final String url;
  final ApiMethod method;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParameters;
  final dynamic body;

  ApiRequest({
    required this.url,
    required this.method,
    this.headers,
    this.queryParameters,
    this.body,
  });
}

class DioHelper {
  final DioClient dioClient;
  DioHelper(this.dioClient);

  Future<Response<T>> request<T>(ApiRequest request) async {
    try {
      final options = Options(
        headers: request.headers,
        method: request.method.name.toUpperCase(),
        responseType: ResponseType.json,
        contentType: 'application/json',
      );

      final response = await dioClient.dio.request<T>(
        request.url,
        options: options,
        queryParameters: request.queryParameters,
        data: request.body,
      );
      return response;
    } on DioException catch (e) {
      throw DioExceptions.map(e);
    } catch (e) {
      throw UnknownException(message: 'Unexpected error: $e');
    }
  }
}
