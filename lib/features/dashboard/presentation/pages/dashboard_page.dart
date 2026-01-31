import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_e_commerce/features/cart/presentation/pages/cart_page.dart';
import 'package:flutter_e_commerce/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:flutter_e_commerce/features/dashboard/presentation/widgets/app_bottom_navigation.dart';
import 'package:flutter_e_commerce/features/home/presentation/pages/home_page.dart';
import 'package:flutter_e_commerce/features/products/presentation/pages/product_collections_page.dart';
import 'package:flutter_e_commerce/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';
import 'package:flutter_e_commerce/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:get/get.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExitOnDoubleBack(
      child: AppScaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: context.colorScheme.background,
        ),
        body: PageView(
          controller: controller.pageController,
          onPageChanged: controller.onPageChanged,
          physics: const BouncingScrollPhysics(),
          children: [
            HomePage(),
            ProductCollectionsPage(),
            CartPage(),
            WishlistPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: const StylishBottomNav(),
      ),
    );
  }
}
