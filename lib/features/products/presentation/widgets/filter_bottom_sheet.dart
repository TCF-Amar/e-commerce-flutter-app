import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/features/products/presentation/controllers/product_category_controller.dart';
import 'package:flutter_e_commerce/features/products/presentation/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class FilterBottomSheet extends StatefulWidget {
  final dynamic controller;
  const FilterBottomSheet({super.key, required this.controller});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final double _minPrice = 1;
  final double _maxPrice = 1000;
  int? _selectedCategory;
  RangeValues _priceRange = const RangeValues(1, 1000);
  final categoryController = Get.find<ProductCategoryController>();

  @override
  void initState() {
    super.initState();
    final controller = widget.controller;
    if (controller is ProductCategoryController) {
      _selectedCategory = controller.selectedCategoryId.value;
      _initPriceRange(controller.priceMin, controller.priceMax);
    } else if (controller is ProductController) {
      _selectedCategory = controller.categoryId;
      _initPriceRange(controller.priceMin, controller.priceMax);
    }
  }

  void _initPriceRange(int? min, int? max) {
    if (min != null && max != null) {
      _priceRange = RangeValues(min.toDouble(), max.toDouble());
    } else {
      _priceRange = const RangeValues(1, 1000);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Price Range"),
                        Text(
                          "\$${_priceRange.start.round()} - \$${_priceRange.end.round()}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    RangeSlider(
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey,
                      min: _minPrice,
                      max: _maxPrice,
                      values: _priceRange,
                      labels: RangeLabels(
                        "\$${_priceRange.start.round()}",
                        "\$${_priceRange.end.round()}",
                      ),
                      divisions: 100,
                      onChanged: (values) {
                        setState(() {
                          _priceRange = values;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text("Category"),

                    // select category but only one category can be selected
                    Obx(
                      () => Wrap(
                        spacing: 8.0,
                        children: categoryController.categories.map((category) {
                          return ChoiceChip(
                            label: Text(category.name),
                            selected: _selectedCategory == category.id,
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategory = selected
                                    ? category.id
                                    : null;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.controller.applyFilters(
                        categoryId: _selectedCategory,
                        priceMin: _priceRange.start.toInt(),
                        priceMax: _priceRange.end.toInt(),
                      );
                      context.pop();
                    },
                    child: const Text("Apply"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.controller.resetFilters();
                      context.pop();
                    },
                    child: const Text("Clear"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
