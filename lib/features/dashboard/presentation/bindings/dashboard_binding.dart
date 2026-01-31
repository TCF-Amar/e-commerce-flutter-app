import 'package:flutter_e_commerce/core/storage/product_storage.dart';
import 'package:flutter_e_commerce/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:flutter_e_commerce/features/cart/presentation/controller/cart_controller.dart';
import 'package:flutter_e_commerce/features/wishlist/presentation/controller/wishlist_controller.dart';
import 'package:get/get.dart';

class DashboardBinding {
  static void init() {
    Get.put(DashboardController());
    Get.put(CartController());
    Get.put(WishlistController(productStorage: Get.find<ProductStorage>()));
  }
}
