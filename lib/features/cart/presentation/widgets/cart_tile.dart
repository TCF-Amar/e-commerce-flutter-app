import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/theme/theme_extensions.dart';

import 'package:flutter_e_commerce/features/cart/presentation/controller/cart_controller.dart';
import 'package:flutter_e_commerce/features/products/data/models/cart_item_model.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartTile extends StatelessWidget {
  final CartItemModel item;
  final CartController controller;

  const CartTile({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 5),
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        children: [
          // Radio Button
          GestureDetector(
            onTap: () => controller.toggleSelection(item.id),
            child: Obx(() {
              final isSelected = controller.selectedItems.contains(item.id);
              return Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? context.colorScheme.success
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? context.colorScheme.success
                        : context.colorScheme.foreground,
                    width: 2,
                  ),
                ),
                child: isSelected ? const Icon(Icons.check, size: 14) : null,
              );
            }),
          ),
          const SizedBox(width: 15),

          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: item.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: context.colorScheme.surface),
              errorWidget: (context, url, _) => Container(
                color: context.colorScheme.surface,
                child: const Icon(Icons.error_outline),
              ),
            ),
          ),
          const SizedBox(width: 15),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.more_vert,
                      size: 20,
                      color: context.colorScheme.foreground,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "Color: Black  Size: L", // Placeholder as requested
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Quantity Control
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            offset: const Offset(0, 2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          _QuantityButton(
                            icon: Icons.remove,
                            onTap: () => controller.updateQuantity(
                              item.id,
                              item.quantity - 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '${item.quantity}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.foreground,
                              ),
                            ),
                          ),
                          _QuantityButton(
                            icon: Icons.add,
                            onTap: () => controller.updateQuantity(
                              item.id,
                              item.quantity + 1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Price
                    Flexible(
                      child: Text(
                        "${item.price.toStringAsFixed(0)}\$",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: context.colorScheme.foreground,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: context.colorScheme.foreground),
      ),
    );
  }
}
