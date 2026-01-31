import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/routes/app_routes.dart';
import 'package:flutter_e_commerce/features/products/presentation/widgets/index.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';
import 'package:flutter_e_commerce/features/wishlist/presentation/controller/wishlist_controller.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class WishlistPage extends GetView<WishlistController> {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.push(AppRoutes.search.path),
          icon: const Icon(Icons.search),
        ),
        title: const Text("Wishlist"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          Obx(
            () => controller.wishlist.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      if (controller.wishlist.isEmpty) {
                        AppSnackbar.info("Wishlist is already empty");
                        return;
                      }
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Clear Wishlist"),
                          content: const Text(
                            "Are you sure you want to delete all items?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => context.pop(),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.clearWishlist();
                                context.pop();
                              },
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.clear_all_outlined),
                  ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.wishlist.isEmpty) {
          return const Center(child: Text("Your wishlist is empty"));
        }
        return ListProductsGrid(
          products: controller.wishlist.reversed
              .map((e) => e.toProduct())
              .toList(),
        );
      }),
    );
  }
}
