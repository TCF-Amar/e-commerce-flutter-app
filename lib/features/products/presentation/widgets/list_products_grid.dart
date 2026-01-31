import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/features/products/domain/entity/product.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/product_card.dart';

class ListProductsGrid extends StatelessWidget {
  final List<Product> products;
  final ScrollController? scrollController;
  final bool asSliver;

  const ListProductsGrid({
    super.key,
    required this.products,
    this.scrollController,
    this.asSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    if (asSliver) {
      return SliverPadding(
        padding: const EdgeInsets.all(15),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.6,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final product = products[index];
            return ProductCard(product: product);
          }, childCount: products.length),
        ),
      );
    }
    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.6,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(product: product);
      },
    );
  }
}
