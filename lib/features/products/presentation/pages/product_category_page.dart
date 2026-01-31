import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_e_commerce/features/products/presentation/controllers/product_category_controller.dart';
import 'package:flutter_e_commerce/features/products/presentation/controllers/product_controller.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';
import 'package:get/get.dart';
import 'package:flutter_e_commerce/features/products/presentation/widgets/index.dart';

class ProductCategoryPage extends StatelessWidget {
  final int category;
  const ProductCategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductCategoryController>();
    final productController = Get.find<ProductController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initCategory(category);
    });

    return AppScaffold(
      appBar: AppBar(
        leading: const BBackButton(),
        title: AppText("Category", fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: context.colorScheme.background,
        surfaceTintColor: context.colorScheme.background,
        centerTitle: true,
        actions: [AppSearchButton(full: false)],
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: controller.scrollController,
        
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyHeaderDelegate(
              
              height: 120,
              child: Column(
                children: [
                  CategorySelector(controller: controller),
                  FilterBar(
                    onSortTap: () => _openSortSheet(context, controller),
                    onFilterTap: () => _openFilterSheet(context, controller),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            if (productController.isLoading.value) {
              return const ProductGridSkeleton(asSliver: true);
            }

            if (productController.products.isEmpty) {
              return const SliverFillRemaining(
                child: Center(
                  child: Text("No products found in this category"),
                ),
              );
            }

            return ListProductsGrid(
              products: productController.products,
              asSliver: true,
            );
          }),
          Obx(() {
            if (productController.isMoreLoading.value) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }),
        ],
      ),
    );
  }

  void _openSortSheet(
    BuildContext context,
    ProductCategoryController controller,
  ) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SortBottomSheet(controller: controller),
    );
  }

  void _openFilterSheet(
    BuildContext context,
    ProductCategoryController controller,
  ) {
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
