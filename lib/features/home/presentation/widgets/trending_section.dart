import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/features/products/presentation/controllers/product_controller.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';

import 'package:get/get.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// HEADER
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Text(
                'Trending',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                autofocus: false,
                onPressed: () {
                  // context.pushNamed(
                  //   AppRoutes.category.name,
                  //   queryParameters: {'category': 'all'},
                  // );
                  AppSnackbar.info("See All");
                },
                child: const Text('See All'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 0),

        /// PRODUCT LIST
        SizedBox(
          height: 260,
          child: Obx(() {
            if (controller.isLoading.value) {
              return const ProductListSkeleton(
                scrollDirection: Axis.horizontal,
              );
            }

            if (controller.products.isEmpty) {
              return const Center(child: Text('No products found'));
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              scrollDirection: Axis.horizontal,
              itemCount: controller.products.length.clamp(0, 5),
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final product = controller.products[index];
                // final isWishlist = controller.wishlist.contains(product.id);
                if (product.trending == true) {
                  return ProductCard(
                    product: product,
                    // onAddToCart: () {},
                    // onWishlist: () {},
                  );
                }
                return ProductCard(
                  product: product,
                  // onAddToCart: () {},
                  // onWishlist: () {},
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
