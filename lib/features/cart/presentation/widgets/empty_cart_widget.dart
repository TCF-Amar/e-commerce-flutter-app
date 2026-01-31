import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/routes/app_routes.dart';
import 'package:flutter_e_commerce/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 20),
          const AppText(
            "Your Cart is Empty",
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: AppText(
              "Looks like you haven't added anything to your cart yet",
              color: Colors.grey,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: AppButton(
              onPressed: () {
                context.go(AppRoutes.dashboard.path);
                try {
                  final dashboardController = Get.find<DashboardController>();
                  dashboardController.changeTab(1);
                } catch (e) {
                  // ignore
                }
              },
              child: const AppText("Explore Collection", color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
