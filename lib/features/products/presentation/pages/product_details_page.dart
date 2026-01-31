import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_e_commerce/features/cart/presentation/controller/cart_controller.dart';
import 'package:flutter_e_commerce/features/products/data/models/cart_item_model.dart';
import 'package:flutter_e_commerce/features/products/data/models/wishlist_model.dart';
import 'package:flutter_e_commerce/features/products/presentation/controllers/product_details_controller.dart';
import 'package:flutter_e_commerce/features/wishlist/presentation/controller/wishlist_controller.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends StatelessWidget {
  final String slug;
  const ProductDetailsPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishlistController>();
    final CartController cartController = Get.find<CartController>();

    final controller = Get.put(
      ProductDetailsController(slug: slug, productsUseCase: Get.find()),
      tag: slug,
    );

    return AppScaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.colorScheme.background,
        surfaceTintColor: context.colorScheme.background,
        title: Obx(
          () => AppText(
            controller.product?.title ?? 'Product Details',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final product = controller.product;
        if (product == null) {
          return const Center(child: Text('Product not found'));
        }

        return Stack(
          children: [
            // Scrollable content
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: 80,
              ), // Space for bottom button
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 400,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 400,
                        viewportFraction: 0.8,
                        // autoPlay: true,
                        // autoPlayInterval: const Duration(seconds: 4),
                        // autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayCurve: Curves.easeInOutCubic,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.1,
                        scrollDirection: Axis.horizontal,
                        pageSnapping: true,
                        onPageChanged: (index, reason) {
                          controller.currentImageIndex.value = index;
                        },
                      ),
                      items: product.images.map((image) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),

                  /// image indicator
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: product.images.asMap().entries.map((entry) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: controller.currentImageIndex.value == entry.key
                              ? 24.0
                              : 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color:
                                controller.currentImageIndex.value == entry.key
                                ? context.colorScheme.primary
                                : Colors.grey.shade300,
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  //
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        /// Size, Quantity, and Save Button Row
                        Row(
                          children: [
                            /// Size Dropdown
                            Expanded(
                              child: Obx(
                                () => DropdownButtonFormField<String>(
                                  initialValue:
                                      controller.selectedSize.value.isEmpty
                                      ? null
                                      : controller.selectedSize.value,
                                  decoration: InputDecoration(
                                    labelText: 'Size',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                  ),
                                  items: ['S', 'M', 'L', 'XL', 'XXL']
                                      .map(
                                        (size) => DropdownMenuItem(
                                          value: size,
                                          child: Text(size),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.selectedSize.value = value;
                                    }
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// Quantity Dropdown
                            Expanded(
                              child: Obx(
                                () => DropdownButtonFormField<int>(
                                  initialValue:
                                      controller.selectedQuantity.value,
                                  decoration: InputDecoration(
                                    labelText: 'Quantity',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                  ),
                                  items: List.generate(10, (index) => index + 1)
                                      .map(
                                        (qty) => DropdownMenuItem(
                                          value: qty,
                                          child: Text(qty.toString()),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.selectedQuantity.value = value;
                                    }
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// Save Button
                            Obx(
                              () => InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  wishlistController.toggleWishlist(
                                    WishlistModel(
                                      id: product.id,
                                      title: product.title,
                                      image: product.images.first,
                                      price: product.price,
                                      slug: product.slug,
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.background,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: context.colorScheme.foreground
                                            .withValues(alpha: 0.1),
                                        blurRadius: 0.1,
                                        spreadRadius: 1,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child:
                                      wishlistController.isInWishlist(
                                        product.id,
                                      )
                                      ? Icon(
                                          Icons.favorite,
                                          color: context.colorScheme.error,
                                          size: 30,
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                          color: context.colorScheme.primary,
                                          size: 30,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        ///title and price
                        ///
                        Row(
                          children: [
                            AppText(
                              product.title,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            const Spacer(),

                            AppText(
                              "\$${product.price}",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        /// Reviews Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              product.category.name,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            // const SizedBox(height: 8),
                            AppText(
                              "4.5/5 (200 reviews)",
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        /// list related product
                        Obx(() {
                          final relatedProducts = controller.relatedProducts;
                          if (relatedProducts == null) {
                            return const SizedBox.shrink();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Related Products',
                                style: context.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: relatedProducts.length,
                                  itemBuilder: (context, index) {
                                    final relatedProduct =
                                        relatedProducts[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: InkWell(
                                        onTap: () {
                                          controller.fetchSingleProductBySlug(
                                            relatedProduct.slug,
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Image.network(
                                            relatedProduct.images.first,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: context
                                                          .colorScheme
                                                          .surface,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                    child: const Icon(
                                                      Icons.image,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }),
                        const SizedBox(height: 16),

                        /// Description Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product.description,
                              style: context.textTheme.bodyMedium?.copyWith(
                                // color: context.colorScheme.onSurfaceVariant,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Fixed bottom Add to Cart button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: ElevatedButton(
                    onPressed: () {
                      cartController.addToCart(
                        CartItemModel(
                          id: product.id,
                          slug: slug,
                          title: product.title,
                          image: product.images.first,
                          price: product.price,
                          quantity: controller.selectedQuantity.value,
                          size: controller.selectedSize.value,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_cart, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          'Add to Cart - \$${product.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
