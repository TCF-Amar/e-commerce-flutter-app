import 'dart:convert';

import 'package:flutter_e_commerce/features/products/data/models/cart_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartStorage {
  final SharedPreferences _prefs;

  CartStorage({required SharedPreferences prefs}) : _prefs = prefs;
  static const String _cartKey = "cart";

  List<CartItemModel> getCartItems() {
    final json = _prefs.getString(_cartKey);
    if (json == null) return [];
    return (jsonDecode(json) as List)
        .map((e) => CartItemModel.fromJson(e))
        .toList();
  }

  Future<void> saveCartItems(List<CartItemModel> items) async {
    final json = items.map((e) => e.toJson()).toList();
    await _prefs.setString(_cartKey, jsonEncode(json));
  }

  Future<void> clearCartItems() async {
    await _prefs.remove(_cartKey);
  }
}
