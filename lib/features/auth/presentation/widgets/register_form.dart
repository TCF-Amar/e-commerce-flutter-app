import 'package:flutter/material.dart';

import 'package:flutter_e_commerce/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/validation/form_validation.dart';

import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';
import 'package:get/get.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Form(
      key: controller.registerFormKey,
      child: Column(
        children: [
          AppTextFormField(
            controller: controller.registerNameController,
            hint: 'Enter your name',
            label: 'Name',
            validator: (value) {
              return FormValidation.validateName(value!);
            },
            prefixIcon: const Icon(Icons.person_outline),
          ),

          SizedBox(height: 16),
          Obx(
            () => AppTextFormField(
              controller: controller.registerEmailController,
              hint: 'Enter your email address',
              label: 'Email',
              validator: (value) {
                final emailError = FormValidation.validateEmail(value!);
                if (emailError != null) {
                  return emailError;
                }
                // Show error if email is NOT available (false = taken)
                if (!controller.isEmailAvailable) {
                  return 'This email is already registered';
                }
                return null;
              },

              prefixIcon: const Icon(Icons.email_outlined),
              suffixIcon: controller.isCheckingEmail
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : controller.isEmailAvailable
                  ? const Icon(Icons.check_circle_outline, color: Colors.green)
                  : controller.registerEmailController.text.isNotEmpty &&
                        FormValidation.validateEmail(
                              controller.registerEmailController.text,
                            ) ==
                            null
                  ? const Icon(Icons.info_outline, color: Colors.red)
                  : null,
            ),
          ),
          SizedBox(height: 16),
          AppTextFormField(
            controller: controller.registerPasswordController,
            hint: 'Enter your password',
            label: 'Password',
            validator: (value) {
              return FormValidation.validatePassword(value!);
            },
            isPassword: true,
            prefixIcon: Icon(Icons.lock_outline),
          ),
          SizedBox(height: 16),
          AppTextFormField(
            controller: controller.registerConfirmPasswordController,
            hint: 'Enter your confirm password',
            label: 'Confirm Password',
            validator: (value) {
              return FormValidation.validateConfirmPassword(
                controller.registerPasswordController.text,
                value!,
              );
            },

            isPassword: true,
            prefixIcon: Icon(Icons.lock_outline),
          ),

          SizedBox(height: 16),
          Obx(
            () => AppButton(
              isLoading: controller.isLoading,
              onPressed: () async {
                final isValid = controller.registerFormKey.currentState!
                    .validate();

                if (isValid) {
                  controller.register();
                }
              },
              child: const Text('Register'),
            ),
          ),
        ],
      ),
    );
  }
}
