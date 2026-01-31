import 'package:flutter_e_commerce/core/storage/product_storage.dart';
import 'package:flutter_e_commerce/features/products/data/models/wishlist_model.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/app_snackbar.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  final ProductStorage productStorage;

  WishlistController({required this.productStorage});

  final wishlist = <WishlistModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadWishlist();
  }

  void loadWishlist() {
    wishlist.assignAll(productStorage.getWishlistProducts());
  }

  Future<void> toggleWishlist(WishlistModel product) async {
    final exists = wishlist.any((element) => element.id == product.id);

    if (exists) {
      wishlist.removeWhere((element) => element.id == product.id);
      AppSnackbar.info("Removed from wishlist", duration: 1);
    } else {
      wishlist.add(product);
      AppSnackbar.info("Added to wishlist", duration: 1);
    }
    await productStorage.saveWishlistProducts(wishlist);
  }

  bool isInWishlist(int productId) {
    return wishlist.any((e) => e.id == productId);
  }

  Future<void> clearWishlist() async {
    wishlist.clear();
    await productStorage.clearWishlistProducts();
    AppSnackbar.info("Wishlist cleared", duration: 1);
  }
}
