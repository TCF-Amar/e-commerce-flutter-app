import 'package:dio/dio.dart';
import 'package:flutter_e_commerce/core/environment/environments.dart';
import 'package:flutter_e_commerce/core/network/interceptors/dio_interceptors.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/manager/auth_session_manager.dart';
import 'package:get/get.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = _createDio();
  }

  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Environments.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        validateStatus: (status) {
          return status != null && status >= 200 && status < 300;
        },
      ),
    );
    // if (!kDebugMode) {
    //   dio.interceptors.add(
    //     LoggingInterceptor(logRequest: true, logResponse: true, logError: true),
    //   );
    // }

    return dio;
  }

  void addInterceptors() {
    _instance.dio.interceptors.add(
      DioInterceptors(Get.find<AuthSessionManager>(), _instance.dio),
    );
  }
}
