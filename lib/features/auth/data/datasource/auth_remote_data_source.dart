import 'package:flutter_e_commerce/features/auth/data/models/auth_response_model.dart';
import 'package:flutter_e_commerce/features/auth/data/models/register_model.dart';
import 'package:flutter_e_commerce/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// to perform login operation
  /// Returns an [AuthResponseModel] on successful login
  Future<AuthResponseModel> login(String email, String password);

  /// to perform refresh access token operation
  /// Returns an [AuthResponseModel] on successful refresh access token
  Future<AuthResponseModel> refreshAccessToken(String refreshToken);

  /// to perform get user profile operation
  /// Returns an [UserModel] on successful get user profile
  Future<UserModel> getUserProfile();

  /// to perform register operation
  /// Returns an [UserModel] on successful register
  Future<UserModel> register(RegisterModel registerModel);

  /// to perform check email operation
  /// Returns an [bool] on successful check email
  Future<bool> checkEmail(String email);
}
