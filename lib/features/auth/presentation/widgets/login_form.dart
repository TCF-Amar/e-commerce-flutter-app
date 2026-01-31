import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/validation/form_validation.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return SizedBox(
      height: 300,
      child: Center(
        child: Form(
          key: controller.loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextFormField(
                controller: controller.loginEmailController,
                hint: 'Enter your email address',
                label: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  return FormValidation.validateEmail(value);
                },
                prefixIcon: Icon(Icons.email_outlined),
              ),
              SizedBox(height: 16),
              AppTextFormField(
                controller: controller.loginPasswordController,
                hint: 'Enter your password',
                label: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return FormValidation.validatePassword(value);
                },
                isPassword: true,
                prefixIcon: Icon(Icons.lock_outline),
              ),
              SizedBox(height: 16),
              Obx(
                () => AppButton(
                  isLoading: controller.isLoading,
                  child: AppText(
                    'Login',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (controller.loginFormKey.currentState!.validate()) {
                      controller.login();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
