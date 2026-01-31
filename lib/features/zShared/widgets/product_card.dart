import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/routes/app_routes.dart';
import 'package:flutter_e_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_e_commerce/features/cart/presentation/controller/cart_controller.dart';
import 'package:flutter_e_commerce/features/products/data/models/cart_item_model.dart';
import 'package:flutter_e_commerce/features/products/data/models/wishlist_model.dart';
import 'package:flutter_e_commerce/features/products/domain/entity/product.dart';
import 'package:flutter_e_commerce/features/wishlist/presentation/controller/wishlist_controller.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;
  final VoidCallback? onWishlist;

  const ProductCard({
    super.key,
    required this.product,
    this.onAddToCart,
    this.onWishlist,
  });

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishlistController>();
    final cartController = Get.find<CartController>();
    return InkWell(
      onTap: () {
        context.pushNamed(
          AppRoutes.productDetails.name,
          queryParameters: {'slug': product.slug},
        );
      },
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          // boxShadow: [
          //   BoxShadow(
          //     color: context.colorScheme.shadow,
          //     blurRadius: 10,
          //     offset: const Offset(0, 4),
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE + WISHLIST
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CachedNetworkImage(
                      imageUrl: product.images.first,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: context.colorScheme.surface,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color: context.colorScheme.surface,
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                ),

                /// Wishlist Button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Obx(() {
                    final isInWishlist = wishlistController.isInWishlist(
                      product.id,
                    );
                    return InkWell(
                      onTap: () {
                        wishlistController.toggleWishlist(
                          WishlistModel(
                            id: product.id,
                            title: product.title,
                            price: product.price,
                            image: product.images.first,
                            slug: product.slug,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: context.colorScheme.card,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isInWishlist ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: isInWishlist
                              ? context.colorScheme.error
                              : context.colorScheme.primary,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// TITLE
            Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 4),

            /// PRICE
            Text(
              "\$${product.price}",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),

            const Spacer(),

            /// ADD TO CART
            SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                onPressed:
                    onAddToCart ??
                    () {
                      cartController.addToCart(
                        CartItemModel(
                          id: product.id,
                          title: product.title,
                          price: product.price,
                          image: product.images.first,
                          slug: product.slug,
                          quantity: 1,
                          size: "L",
                        ),
                      );
                    },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: context.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  "Add to cart",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
