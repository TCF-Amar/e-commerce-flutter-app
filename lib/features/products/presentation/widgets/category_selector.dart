import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/features/products/presentation/controllers/product_category_controller.dart';
import 'package:flutter_e_commerce/core/theme/theme_extensions.dart';
import 'package:get/get.dart';

class CategorySelector extends StatelessWidget {
  final ProductCategoryController controller;

  const CategorySelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Obx(() {
        final categories = controller.categories;
        final selectedId = controller.selectedCategoryId.value;
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: categories.length + 1,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            if (index == 0) {
              return _CategoryItem(
                name: "All",
                isSelected: selectedId == null || selectedId == 0,
                onTap: () => controller.selectCategory(null),
              );
            }
            final category = categories[index - 1];
            return _CategoryItem(
              name: category.name,
              isSelected: selectedId == category.id,
              onTap: () => controller.selectCategory(category.id),
            );
          },
        );
      }),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ActionChip(
      onPressed: onTap,
      label: Row(
        children: [
          if (isSelected) ...[
            Icon(Icons.check, size: 16),
            const SizedBox(width: 4),
          ],
          Text(name),
        ],
      ),

      backgroundColor: isSelected ? context.colorScheme.surface : null,
      labelStyle: isSelected
          ? theme.textTheme.labelLarge?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
            )
          : null,
      side: isSelected ? BorderSide.none : null,
      shape: const StadiumBorder(),
    );
  }
}
