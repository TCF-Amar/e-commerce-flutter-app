import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/routes/app_routes.dart';
import 'package:flutter_e_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_e_commerce/features/cart/presentation/controller/cart_controller.dart';
import 'package:flutter_e_commerce/features/products/presentation/controllers/product_search_controller.dart';
import 'package:flutter_e_commerce/features/products/presentation/widgets/index.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ProductSearchPage extends GetView<ProductSearchController> {
  const ProductSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: [
          Obx(() {
            final count = cartController.totalItem;
            return Badge(
              offset: const Offset(-5, 5),
              isLabelVisible: count > 0,
              backgroundColor: context.colorScheme.error,
              padding: const EdgeInsets.all(2),
              label: Text(
                "${count > 9 ? "9+" : count}",
                style: context.textTheme.bodySmall,
              ),
              child: IconButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.cart.name);
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
            );
          }),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: AppTextFormField(
              controller: controller.queryController,
              hint: "Search Products",
              prefixIcon: const Icon(Icons.search),

              suffixIcon: ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller.queryController,
                builder: (context, value, child) {
                  if (value.text.isNotEmpty) {
                    return IconButton(
                      onPressed: () {
                        controller.queryController.clear();
                      },
                      icon: const Icon(Icons.close),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              autoFocus: true,
            ),
          ),
          Expanded(
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                Obx(() {
                  if (controller.recentSearches.isEmpty ||
                      controller.queryController.text.isNotEmpty ||
                      controller.products.isNotEmpty) {
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  }
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recent Searches",
                                style: context.textTheme.titleMedium,
                              ),
                              TextButton(
                                onPressed: controller.clearRecentSearches,
                                child: const Text("Clear"),
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: controller.recentSearches.reversed
                                .map(
                                  (search) => ActionChip(
                                    avatar: const Icon(Icons.history, size: 16),
                                    label: Text(search),
                                    onPressed: () {
                                      controller.queryController.text = search;
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const ProductGridSkeleton(asSliver: true);
                  }

                  if (controller.products.isEmpty &&
                      controller.queryController.text.isNotEmpty) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: Text("No products found")),
                    );
                  }

                  if (controller.products.isEmpty) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: Text("Search for products")),
                    );
                  }

                  return ListProductsGrid(
                    products: controller.products,
                    asSliver: true,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
