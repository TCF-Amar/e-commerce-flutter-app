import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final _currentIndex = 0.obs;
  late final PageController pageController;

  int get currentIndex => _currentIndex.value;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changeTab(int index) {
    if (_currentIndex.value == index) return;
    _currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    _currentIndex.value = index;
  }
}
