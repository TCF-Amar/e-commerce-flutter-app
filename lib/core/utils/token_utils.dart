import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenUtils {
  /// true = token expired
  static bool isExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  /// remaining time
  static Duration remainingTime(String token) {
    final remainingTime = JwtDecoder.getRemainingTime(token);
    debugPrint('Remaining time: ${remainingTime.inMinutes} minutes');
    return remainingTime;
  }

  /// refresh needed if < 5 minutes
  static bool shouldRefresh(String token) {
    final remainingTime = TokenUtils.remainingTime(token);
    debugPrint('Remaining time: ${remainingTime.inMinutes} minutes');
    return remainingTime.inMinutes < 5;
  }
}
