import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/features/products/presentation/controllers/product_controller.dart';
import 'package:flutter_e_commerce/features/products/presentation/widgets/index.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';
import 'package:get/get.dart';

class ProductCollectionsPage extends StatelessWidget {
  const ProductCollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.init();
    });

    return AppScaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.resetFilters();
          await controller.fetchProducts();
        },
        child: SafeArea(
          child: Column(
            children: [
              const AppSearchButton(),
              FilterBar(
                onSortTap: () => _openSortSheet(context, controller),
                onFilterTap: () => _openFilterSheet(context, controller),
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return Expanded(
                    child: const ProductGridSkeleton(asSliver: false),
                  );
                }
                return Expanded(
                  child: controller.products.isEmpty
                      ? const _EmptyState()
                      : ListProductsGrid(
                          products: controller.products,
                          scrollController: controller.scrollController,
                        ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _openSortSheet(BuildContext context, ProductController controller) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SortBottomSheet(controller: controller),
    );
  }

  void _openFilterSheet(BuildContext context, ProductController controller) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => FilterBottomSheet(controller: controller),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: const Center(
              child: Text("No products found", style: TextStyle(fontSize: 16)),
            ),
          ),
        );
      },
    );
  }
}
