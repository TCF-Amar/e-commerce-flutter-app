import 'package:flutter_e_commerce/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce/features/auth/data/models/register_model.dart';
import 'package:flutter_e_commerce/features/auth/domain/entities/auth_response.dart';
import 'package:flutter_e_commerce/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  /// to perform login operation
  /// Returns an [AuthResponse] on successful login
  Future<Either<Failure, AuthResponse>> login(String email, String password);

  /// to perform refresh access token operation
  /// Returns an [AuthResponse] on successful refresh access token
  Future<Either<Failure, AuthResponse>> refreshAccessToken(String refreshToken);

  /// to perform get user profile operation
  /// Returns an [UserProfileEntity] on successful get user profile
  Future<Either<Failure, UserProfileEntity>> getUserProfile();

  /// to perform check email operation
  /// Returns an [bool] on successful check email
  Future<Either<Failure, bool>> checkEmail(String email);

  /// to perform register operation
  /// Returns an [UserProfileEntity] on successful register
  Future<Either<Failure, UserProfileEntity>> register(RegisterModel register);
}
