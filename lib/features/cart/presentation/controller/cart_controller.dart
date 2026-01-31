import 'package:flutter_e_commerce/core/db/cart_database.dart';
import 'package:flutter_e_commerce/features/products/data/models/cart_item_model.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';

import 'package:get/get.dart';

class CartController extends GetxController {
  final CartDatabase cartDatabase = Get.find();
  final RxSet<int> selectedItems = <int>{}.obs;
  final RxList<CartItemModel> cart = <CartItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  Future<void> addToCart(CartItemModel item) async {
    final existingItem = cart.firstWhereOrNull((e) => e.slug == item.slug);
    if (existingItem != null) {
      await updateQuantity(
        existingItem.id,
        existingItem.quantity + item.quantity,
      );
    } else {
      await cartDatabase.create(item);
    }
    AppSnackbar.success("Item added to cart", title: "Cart", duration: 2);
    // print(totalItem);

    await getCart();
  }

  Future<void> removeFromCart(int id) async {
    await cartDatabase.delete(id);
    selectedItems.remove(id);
    await getCart();
  }

  Future<void> removeSelected() async {
    final itemsToRemove = selectedItems.toList();
    for (var id in itemsToRemove) {
      await removeFromCart(id);
    }
  }

  Future<void> updateCart(CartItemModel item) async {
    await cartDatabase.update(item);
    await getCart();
  }

  Future<void> updateQuantity(int id, int quantity) async {
    if (quantity < 1) {
      removeFromCart(id);
    }
    final index = cart.indexWhere((item) => item.id == id);
    if (index != -1) {
      final oldItem = cart[index];
      final newItem = oldItem.copyWith(quantity: quantity);
      await updateCart(newItem);
    }
  }

  Future<void> getCart() async {
    final items = await cartDatabase.readAll();
    cart.assignAll(items);
    selectedItems.removeWhere((id) => !cart.any((item) => item.id == id));
  }

  void toggleSelection(int id) {
    if (selectedItems.contains(id)) {
      selectedItems.remove(id);
    } else {
      selectedItems.add(id);
    }
  }

  void toggleAllSelection() {
    if (isAllSelected) {
      selectedItems.clear();
    } else {
      selectedItems.addAll(cart.map((e) => e.id));
    }
  }

  bool get isAllSelected =>
      cart.isNotEmpty && selectedItems.length == cart.length;

  double get subTotal => cart
      .where((item) => selectedItems.contains(item.id))
      .fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  double get shippingPrice => subTotal > 0 ? 24.0 : 0.0;

  double get grandTotal => subTotal + shippingPrice;

  int get totalItem => cart.fold(0, (sum, item) => sum + item.quantity);
}
