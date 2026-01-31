import 'package:flutter_e_commerce/features/auth/domain/entities/auth_response.dart';

class AuthResponseModel extends AuthResponse {
  const AuthResponseModel(super.accessToken, super.refreshToken);
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      json['access_token'] as String,
      json['refresh_token'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {'access_token': accessToken, 'refresh_token': refreshToken};
  }

  AuthResponse toEntity() {
    return AuthResponse(accessToken, refreshToken);
  }
}
