import 'package:flutter_e_commerce/core/di/core_modules.dart';
import 'package:flutter_e_commerce/core/di/network_module.dart';

import 'package:flutter_e_commerce/features/auth/presentation/bindings/auth_bindings.dart';
import 'package:flutter_e_commerce/features/dashboard/presentation/bindings/dashboard_binding.dart';
import 'package:flutter_e_commerce/features/products/presentation/bindings/product_binding.dart';
import 'package:flutter_e_commerce/features/zShared/Controllers/theme_controller.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static Future<void> init() async {
    Get.put(ThemeController());
    await _coreModules();
    _featuresModules();
  }

  static Future<void> _coreModules() async {
    await CoreModules.init();
    NetworkModule.init();
  }

  static void _featuresModules() {
    AuthBindings.init();
    DashboardBinding.init();
    ProductBinding.init();
  }
}
