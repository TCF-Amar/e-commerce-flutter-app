import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BBackButton extends StatelessWidget {
  const BBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () => context.pop(),
    );
  }
}
