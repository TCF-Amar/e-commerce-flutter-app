import 'dart:developer' as developer;

import 'package:flutter_e_commerce/core/error/failure.dart';
import 'package:flutter_e_commerce/core/error/failure_type.dart';
import 'exceptions.dart';

class ApiException {
  static Failure map(AppException e) {
    return Failure(
      message: e.message,
      type: _mapType(e),
      statusCode: e.statusCode,
    );
  }

  static FailureType _mapType(AppException e) {
    developer.log(
      '┌──────────────────────────────────────────────────────────────',
      name: 'ApiException',
    );
    developer.log(
      "│ Api Exception Type: ${e.runtimeType}",
      name: "ApiException",
    );
    developer.log(
      "│ Api Exception Message: ${e.toString()}",
      name: "ApiException",
    );

    late FailureType type;

    if (e is NetworkException) {
      developer.log("│ NetworkException", name: "ApiException");
      type = FailureType.network;
    } else if (e is TimeoutException) {
      developer.log("│ TimeoutException", name: "ApiException");
      type = FailureType.timeout;
    } else if (e is UnauthorizedException) {
      developer.log("│ UnauthorizedException", name: "ApiException");
      type = FailureType.unauthorized;
    } else if (e is ForbiddenException) {
      developer.log("│ ForbiddenException", name: "ApiException");
      type = FailureType.forbidden;
    } else if (e is NotFoundException) {
      developer.log("│ NotFoundException", name: "ApiException");
      type = FailureType.notFound;
    } else if (e is ValidationException) {
      developer.log("│ ValidationException", name: "ApiException");
      type = FailureType.validation;
    } else if (e is ConflictException) {
      developer.log("│ ConflictException", name: "ApiException");
      type = FailureType.conflict;
    } else if (e is BadRequestException) {
      developer.log("│ BadRequestException", name: "ApiException");
      type = FailureType.badRequest;
    } else if (e is CancellationException) {
      developer.log("│ CancellationException", name: "ApiException");
      type = FailureType.cancelled;
    } else if (e is ServerException) {
      developer.log("│ ServerException", name: "ApiException");
      type = FailureType.server;
    } else if (e is ClientException) {
      developer.log("│ ClientException", name: "ApiException");
      type = FailureType.client;
    } else {
      developer.log(
        "│ No match - returning FailureType.unknown",
        name: "ApiException",
      );
      type = FailureType.unknown;
    }

    developer.log(
      '└──────────────────────────────────────────────────────────────',
      name: 'ApiException',
    );
    return type;
  }
}

extension ApiExceptionX on AppException {
  Failure toFailure() => ApiException.map(this);
}
