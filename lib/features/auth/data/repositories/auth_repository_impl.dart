import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/error/failure.dart';
import 'package:flutter_e_commerce/core/error/failure_type.dart';
import 'package:flutter_e_commerce/core/network/exceptions/api_exceptions.dart';
import 'package:flutter_e_commerce/core/network/exceptions/exceptions.dart';
import 'package:flutter_e_commerce/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_e_commerce/features/auth/data/models/register_model.dart';
import 'package:flutter_e_commerce/features/auth/domain/entities/auth_response.dart';
import 'package:flutter_e_commerce/features/auth/domain/entities/user.dart';
import 'package:flutter_e_commerce/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, AuthResponse>> login(
    String email,
    String password,
  ) async {
    try {
      final model = await dataSource.login(email, password);

      return Right(model.toEntity());
    } on AppException catch (e) {
      return Left(ApiException.map(e));
    } catch (e) {
      debugPrint("error: $e");
      return Left(
        Failure(type: FailureType.unknown, message: 'Something went wrong'),
      );
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> refreshAccessToken(
    String refreshToken,
  ) async {
    try {
      final model = await dataSource.refreshAccessToken(refreshToken);

      return Right(model.toEntity());
    } on AppException catch (e) {
      return Left(ApiException.map(e));
    } catch (_) {
      return Left(
        Failure(type: FailureType.unknown, message: 'Something went wrong'),
      );
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> getUserProfile() async {
    try {
      final model = await dataSource.getUserProfile();
      debugPrint("model: ${model.toString()}");
      return Right(model.toEntity());
    } on AppException catch (e) {
      return Left(ApiException.map(e));
    } catch (_) {
      return Left(
        Failure(type: FailureType.unknown, message: 'Something went wrong'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmail(String email) async {
    try {
      final model = await dataSource.checkEmail(email);
      return Right(model);
    } on AppException catch (e) {
      return Left(ApiException.map(e));
    } catch (_) {
      return Left(
        Failure(type: FailureType.unknown, message: 'Something went wrong'),
      );
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> register(
    RegisterModel register,
  ) async {
    try {
      final model = await dataSource.register(register);
      return Right(model.toEntity());
    } on AppException catch (e) {
      return Left(ApiException.map(e));
    } catch (_) {
      return Left(
        Failure(type: FailureType.unknown, message: 'Something went wrong'),
      );
    }
  }
}
