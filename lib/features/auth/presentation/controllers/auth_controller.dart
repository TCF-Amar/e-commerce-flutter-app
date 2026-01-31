import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/routes/app_router.dart';
import 'package:flutter_e_commerce/core/routes/app_routes.dart';
import 'package:flutter_e_commerce/features/auth/data/models/register_model.dart';
import 'package:flutter_e_commerce/features/auth/domain/entities/user.dart';
import 'package:flutter_e_commerce/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/manager/auth_session_manager.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/validation/form_validation.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/app_snackbar.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthUsecase authUsecase;
  final AuthSessionManager authSessionManager;

  AuthController(this.authUsecase, this.authSessionManager);

  /// loaders
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxBool _isCheckingEmail = false.obs;
  bool get isCheckingEmail => _isCheckingEmail.value;

  final RxBool _isEmailAvailable = false.obs;
  bool get isEmailAvailable => _isEmailAvailable.value;

  UserProfileEntity? get profile => authSessionManager.userProfile;

  // controllers
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  // form keys
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();

    registerEmailController.addListener(() {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 800), () {
        checkEmail();
      });
    });
  }

  /// LOGIN
  Future<void> login() async {
    _isLoading.value = true;

    final emailError = FormValidation.validateEmail(loginEmailController.text);
    final passwordError = FormValidation.validatePassword(
      loginPasswordController.text,
    );

    if (emailError != null || passwordError != null) {
      AppSnackbar.error(emailError ?? passwordError!);
      _isLoading.value = false;
      return;
    }

    final result = await authUsecase.login(
      loginEmailController.text.trim(),
      loginPasswordController.text.trim(),
    );

    result.fold(
      (failure) {
        AppSnackbar.error(
          "Login failed email or password is not correct",
          title: "Failure",
          duration: 1,
        );
        _isLoading.value = false;
      },
      (authResponse) async {
        await authSessionManager.saveSession(
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
        );
        await authSessionManager.fetchUserProfile();
        AppSnackbar.success("Logged in successfully");
        _isLoading.value = false;
      },
    );
  }

  /// CHECK EMAIL AVAILABILITY
  Future<void> checkEmail() async {
    final email = registerEmailController.text.trim();

    final emailError = FormValidation.validateEmail(email);
    if (email.isEmpty || emailError != null) {
      _isEmailAvailable.value = false;
      _isCheckingEmail.value = false;
      return;
    }

    _isCheckingEmail.value = true;

    final result = await authUsecase.checkEmail(email);

    result.fold(
      (failure) {
        // API error → assume unavailable for safety
        _isEmailAvailable.value = false;
      },
      (isAvailable) {
        _isEmailAvailable.value = true;
      },
    );

    _isCheckingEmail.value = false;
  }

  /// REGISTER
  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;

    _isLoading.value = true;

    final result = await authUsecase.register(
      RegisterModel(
        name: registerNameController.text.trim(),
        email: registerEmailController.text.trim(),
        password: registerPasswordController.text.trim(),
      ),
    );

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
        _isLoading.value = false;
      },
      (_) async {
        AppSnackbar.success(
          "${registerNameController.text.trim()}, your account has been created successfully Login with your email and password",
          title: "Registration Successful",
        );
        _isLoading.value = false;
        AppRouter.router.push(AppRoutes.login.toString());
        registerNameController.clear();
        registerEmailController.clear();
        registerPasswordController.clear();
        registerConfirmPasswordController.clear();
      },
    );
  }

  /// LOGOUT
  Future<void> logout() async {
    await authSessionManager.clearSession();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    super.onClose();
  }
}
