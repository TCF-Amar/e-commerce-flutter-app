import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce/core/error/failure.dart';
import 'package:flutter_e_commerce/features/auth/data/models/register_model.dart';
import 'package:flutter_e_commerce/features/auth/domain/entities/auth_response.dart';
import 'package:flutter_e_commerce/features/auth/domain/entities/user.dart';
import 'package:flutter_e_commerce/features/auth/domain/repositories/auth_repository.dart';

class AuthUsecase {
  final AuthRepository _authRepository;

  AuthUsecase(this._authRepository);

  Future<Either<Failure, AuthResponse>> login(
    String email,
    String password,
  ) async {
    return _authRepository.login(email, password);
  }

  Future<Either<Failure, AuthResponse>> refreshAccessToken(
    String refreshToken,
  ) async {
    return _authRepository.refreshAccessToken(refreshToken);
  }

  Future<Either<Failure, UserProfileEntity>> getUserProfile() async {
    return _authRepository.getUserProfile();
  }

  Future<Either<Failure, bool>> checkEmail(String email) async {
    return _authRepository.checkEmail(email);
  }

  Future<Either<Failure, UserProfileEntity>> register(RegisterModel res) async {
    return _authRepository.register(res);
  }
}
