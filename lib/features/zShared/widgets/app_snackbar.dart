import 'package:flutter/material.dart';

class AppSnackbar {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void success(String message, {String? title, int duration = 3}) {
    _showSnackbar(
      title: title ?? 'Success',
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
      duration: duration,
    );
  }

  static void error(String message, {String? title, int duration = 3}) {
    _showSnackbar(
      title: title ?? 'Error',
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.error,
      duration: duration,
    );
  }

  static void warning(String message, {String? title, int duration = 3}) {
    _showSnackbar(
      title: title ?? 'Warning',
      message: message,
      backgroundColor: Colors.orange,
      icon: Icons.warning,
      duration: duration,
    );
  }

  static void info(String message, {String? title, int duration = 3}) {
    _showSnackbar(
      title: title ?? 'Info',
      message: message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
      duration: duration,
    );
  }

  static void _showSnackbar({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    int duration = 3,
  }) {
    final messenger = scaffoldMessengerKey.currentState;

    if (messenger == null) {
      debugPrint(
        'AppSnackbar: ScaffoldMessenger not available. Message: $message',
      );
      return;
    }

    messenger.clearSnackBars();

    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        // margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: Duration(seconds: duration),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
