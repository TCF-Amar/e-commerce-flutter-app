import 'package:flutter_e_commerce/core/network/dio_client.dart';
import 'package:flutter_e_commerce/core/storage/token_storage.dart';
import 'package:flutter_e_commerce/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_e_commerce/features/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'package:flutter_e_commerce/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_e_commerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_e_commerce/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/manager/auth_session_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthBindings {
  static void init() {
    // Initialize authentication-related dependencies here
    // 1. data source
    Get.put<AuthRemoteDataSource>(AuthRemoteDataSourceImpl(Get.find()));
    // 2. repository
    Get.put<AuthRepository>(AuthRepositoryImpl(Get.find()));

    // 3. use case
    Get.put<AuthUsecase>(AuthUsecase(Get.find()));

    // 4. controller
    final FlutterSecureStorage storage = FlutterSecureStorage();

    Get.put<AuthSessionManager>(
      AuthSessionManager(Get.put(TokenStorage(storage)), Get.find()),
    );
    // add dio interceptors
    Get.find<DioClient>().addInterceptors();
    Get.put<AuthController>(AuthController(Get.find(), Get.find()));
  }
}
