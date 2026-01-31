import 'package:flutter/foundation.dart';
import 'package:flutter_e_commerce/core/network/exceptions/exceptions.dart';

class HandleErrorResponse {
  static void handle(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('statusCode')) {
      final statusCode = data['statusCode'] as int;
      final message = data['message'] as String? ?? 'Request failed';

      debugPrint("API Exception Message: $message");
      debugPrint("API Exception Status Code: $statusCode");

      switch (statusCode) {
        case 401:
          throw UnauthorizedException(message: message, data: data);
        case 403:
          throw ForbiddenException(message: message, data: data);
        case 404:
          throw NotFoundException(message: message, data: data);
        case 400:
          throw BadRequestException(
            message: message,
            statusCode: statusCode,
            data: data,
          );
        case >= 500:
          throw ServerException(
            message: message,
            statusCode: statusCode,
            data: data,
          );
        default:
          throw ClientException(
            message: message,
            statusCode: statusCode,
            data: data,
          );
      }
    }
  }
}
