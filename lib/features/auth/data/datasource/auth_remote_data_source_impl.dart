import 'package:flutter_e_commerce/core/constants/api_end_points.dart';
import 'package:flutter_e_commerce/core/error/handel_error_response.dart';
import 'package:flutter_e_commerce/core/network/dio_helper.dart';
import 'package:flutter_e_commerce/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_e_commerce/features/auth/data/models/auth_response_model.dart';
import 'package:flutter_e_commerce/features/auth/data/models/register_model.dart';
import 'package:flutter_e_commerce/features/auth/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioHelper dioHelper;
  AuthRemoteDataSourceImpl(this.dioHelper);

  @override
  Future<AuthResponseModel> login(String email, String password) async {
    final response = await dioHelper.request(
      ApiRequest(
        url: ApiEndpoints.login,
        method: ApiMethod.post,
        body: {'email': email, 'password': password},
      ),
    );

    HandleErrorResponse.handle(response.data);
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> refreshAccessToken(String refreshToken) async {
    final response = await dioHelper.request(
      ApiRequest(
        url: ApiEndpoints.refreshToken,
        method: ApiMethod.post,
        body: {'refreshToken': refreshToken},
      ),
    );

    HandleErrorResponse.handle(response.data);
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<UserModel> getUserProfile() async {
    final response = await dioHelper.request(
      ApiRequest(url: ApiEndpoints.profile, method: ApiMethod.get),
    );
    HandleErrorResponse.handle(response.data);
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> register(RegisterModel registerModel) async {
    final response = await dioHelper.request(
      ApiRequest(
        url: ApiEndpoints.users,
        method: ApiMethod.post,
        body: registerModel.toJson(),
      ),
    );

    HandleErrorResponse.handle(response.data);
    return UserModel.fromJson(response.data);
  }

  @override
  Future<bool> checkEmail(String email) async {
    final response = await dioHelper.request(
      ApiRequest(
        url: ApiEndpoints.checkEmail,
        method: ApiMethod.post,
        body: {'email': email},
      ),
    );

    HandleErrorResponse.handle(response.data);
    return response.data['isAvailable'];
  }
}
