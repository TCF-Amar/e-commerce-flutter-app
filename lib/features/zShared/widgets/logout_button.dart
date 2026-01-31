import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/app_bottom_alert.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/app_text.dart';
import 'package:get/get.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          final bool result = await showBottomAlert(
            context: context,
            title: 'Logout',
            message: 'Are you sure you want to logout?',
            confirmText: 'Logout',
            cancelText: 'Cancel',
            isDestructive: true,
          );
          if (result == true) {
            authController.logout();
          }
        },
        child: const AppText(
          'Logout',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
