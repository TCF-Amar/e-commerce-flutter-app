import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  void toggleTheme(ThemeMode mode) {
    themeMode.value = mode;
  }

  void cycleTheme() {
    switch (themeMode.value) {
      case ThemeMode.light:
        themeMode.value = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        themeMode.value = ThemeMode.system;
        break;
      case ThemeMode.system:
        themeMode.value = ThemeMode.light;
        break;
    }
  }
}
