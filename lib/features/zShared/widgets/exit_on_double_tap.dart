import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_e_commerce/core/theme/theme_extensions.dart';

class ExitOnDoubleBack extends StatefulWidget {
  final Widget child;
  const ExitOnDoubleBack({super.key, required this.child});

  @override
  State<ExitOnDoubleBack> createState() => _ExitOnDoubleBackState();
}

class _ExitOnDoubleBackState extends State<ExitOnDoubleBack> {
  DateTime? _lastPressed;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        final now = DateTime.now();

        if (_lastPressed == null ||
            now.difference(_lastPressed!) > const Duration(seconds: 2)) {
          _lastPressed = now;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: context.colorScheme.foreground,
              content: const Text('Press back again to exit'),
              duration: const Duration(seconds: 2),
            ),
          );
          return;
        }

        SystemNavigator.pop();
      },
      child: widget.child,
    );
  }
}
