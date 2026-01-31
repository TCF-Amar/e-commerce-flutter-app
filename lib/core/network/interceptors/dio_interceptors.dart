import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter_e_commerce/core/constants/api_end_points.dart';

import 'package:flutter_e_commerce/core/utils/token_utils.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/manager/auth_session_manager.dart';

class DioInterceptors extends Interceptor {
  final AuthSessionManager _session;
  final Dio _dio;

  DioInterceptors(this._session, this._dio);

  bool _isPublic(RequestOptions o) {
    return o.path.contains(ApiEndpoints.login) ||
        o.path.contains(ApiEndpoints.refreshToken);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isPublic(options)) {
      return handler.next(options);
    }
    final token = await _session.getAccessToken();
    if (token != null && token.isNotEmpty) {
      if (TokenUtils.shouldRefresh(token)) {
        await _session.refreshAccessToken();
      }
      final newToken = await _session.getAccessToken();
      if (newToken != null) {
        options.headers['Authorization'] = 'Bearer $newToken';
      }
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isPublic(err.requestOptions)) {
      developer.log("LOL 401 error aaya ", name: "DioInterceptors");
      final newToken = await _session.refreshAccessToken();

      if (newToken != null && newToken.isNotEmpty) {
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $newToken';

        try {
          final response = await _dio.fetch(options);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      } else {

        return handler.next(err);
      }
    }
    handler.next(err);
  }
}
