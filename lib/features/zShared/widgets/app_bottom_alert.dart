import 'package:flutter/material.dart';

Future<bool> showBottomAlert({
  required BuildContext context,
  String title = 'Confirm',
  String message = 'Are you sure?',
  String confirmText = 'Yes',
  String cancelText = 'No',
  IconData? confirmIcon,
  IconData? cancelIcon,
  bool isDestructive = false,
  Color? confirmBackgroundColor,
  Color? cancelBackgroundColor,
  Color? confirmTextColor,
  Color? cancelTextColor,
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      final theme = Theme.of(context);

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Drag handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              const SizedBox(height: 16),

              /// Title
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              /// Message
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  /// Cancel Button
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context, false),
                      icon: cancelIcon != null
                          ? Icon(cancelIcon, size: 18, color: cancelTextColor)
                          : null,
                      label: Text(
                        cancelText,
                        style: TextStyle(color: cancelTextColor),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: cancelBackgroundColor,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// Confirm Button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context, true),
                      icon: confirmIcon != null
                          ? Icon(
                              confirmIcon,
                              size: 18,
                              color: confirmTextColor ?? Colors.white,
                            )
                          : null,
                      label: Text(
                        confirmText,
                        style: TextStyle(
                          color: confirmTextColor ?? Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            confirmBackgroundColor ??
                            (isDestructive
                                ? Colors.red
                                : theme.colorScheme.primary),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );

  return result ?? false;
}
