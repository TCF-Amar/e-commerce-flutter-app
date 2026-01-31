import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/routes/app_routes.dart';
import 'package:flutter_e_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_e_commerce/features/cart/presentation/controller/cart_controller.dart';
import 'package:flutter_e_commerce/features/cart/presentation/widgets/cart_tile.dart';
import 'package:flutter_e_commerce/features/cart/presentation/widgets/check_out_bar.dart';
import 'package:flutter_e_commerce/features/cart/presentation/widgets/empty_cart_widget.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: context.colorScheme.background,
        surfaceTintColor: context.colorScheme.background,

        elevation: 0,

        title: Obx(
          () => AppText(
            "My Cart (${controller.cart.length} items)",
            fontSize: 20,
          ),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () {
              context.push(AppRoutes.search.path);
            },
            icon: const Icon(Icons.search),
          ),

          Obx(
            () => controller.selectedItems.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Clear Cart"),
                            content: Text(
                              "Are you sure you want to clear all items from your cart?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  controller.removeSelected();
                                  context.pop();
                                },
                                child: Text("Clear"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.clear_all),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.cart.isEmpty) {
                  return const EmptyCartWidget();
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: controller.cart.length,
                  itemBuilder: (context, index) {
                    final item = controller.cart[index];
                    return CartTile(item: item, controller: controller);
                  },
                );
              }),
            ),

            // Bottom Section
            Obx(() {
              if (controller.cart.isEmpty) {
                return const SizedBox.shrink();
              }
              return CheckOutBar();
            }),
          ],
        ),
      ),
    );
  }
}
