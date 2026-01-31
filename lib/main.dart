import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/di/dependency_injection.dart';
import 'package:flutter_e_commerce/core/routes/app_router.dart';
import 'package:flutter_e_commerce/core/theme/app_theme.dart';
import 'package:flutter_e_commerce/features/zShared/Controllers/theme_controller.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/app_snackbar.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjection.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MaterialApp.router(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: Get.find<ThemeController>().themeMode.value,
        routerConfig: AppRouter.router,
        title: 'E-Commerce App',
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: AppSnackbar.scaffoldMessengerKey,
      ),
    );
  }
}
