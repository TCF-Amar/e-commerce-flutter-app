import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_e_commerce/features/cart/presentation/controller/cart_controller.dart';
import 'package:flutter_e_commerce/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';
import 'package:get/get.dart';

class StylishBottomNav extends GetView<DashboardController> {
  const StylishBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final color = context.colorScheme;
    return Obx(
      () => NavigationBar(
        selectedIndex: controller.currentIndex,
        height: 70,
        backgroundColor: color.background,
        onDestinationSelected: controller.changeTab,
        elevation: 10,
        shadowColor: color.surface,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        labelPadding: const EdgeInsets.symmetric(horizontal: 0),
        indicatorColor: color.background,
        indicatorShape: const CircleBorder(),
        // surfaceTintColor: color.surface,
        // surfaceTintColor: context.colorScheme.surface,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'Collection',
          ),
          Badge(
            label: AppText(
              "${cartController.totalItem}",
              fontSize: 10,
              color: Colors.white,
            ),
            isLabelVisible: cartController.totalItem > 0,
            backgroundColor: color.primary,

            largeSize: 15,
            smallSize: 15,
            padding: EdgeInsets.all(3),
            offset: Offset(-15, 15),
            child: NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              selectedIcon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
