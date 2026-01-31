import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/utils/product_sort_util.dart';
import 'package:go_router/go_router.dart';

class SortBottomSheet extends StatelessWidget {
  final dynamic controller;

  const SortBottomSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sort by",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _SortTile(
              title: "Relative",
              controller: controller,
              sort: ProductSort.relative,
            ),
            _SortTile(
              title: "Price: Low to High",
              controller: controller,
              sort: ProductSort.priceLowToHigh,
            ),
            _SortTile(
              title: "Price: High to Low",
              controller: controller,
              sort: ProductSort.priceHighToLow,
            ),
            _SortTile(
              title: "Ascending",
              controller: controller,
              sort: ProductSort.aToZ,
            ),
            _SortTile(
              title: "Descending",
              controller: controller,
              sort: ProductSort.zToA,
            ),
            // const SizedBox(height: 26),
          ],
        ),
      ),
    );
  }
}

class _SortTile extends StatelessWidget {
  final String title;
  final dynamic controller;
  final ProductSort sort;

  const _SortTile({
    required this.title,
    required this.controller,
    required this.sort,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        controller.sortProducts(sort);
        context.pop();
      },
    );
  }
}
