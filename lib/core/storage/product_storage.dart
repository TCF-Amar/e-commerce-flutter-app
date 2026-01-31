import 'dart:convert';
import 'package:flutter_e_commerce/features/products/data/models/wishlist_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductStorage {
  final SharedPreferences _prefs;

  ProductStorage(this._prefs);

  static const String _wishlistKey = 'wishlist_products';
  static const String _recentSearchKey = 'recent_search';

  /// Save wishlist
  Future<void> saveWishlistProducts(List<WishlistModel> products) async {
    final jsonList = products.map((e) => jsonEncode(e.toJson())).toList();

    await _prefs.setStringList(_wishlistKey, jsonList);
  }

  /// Get wishlist
  List<WishlistModel> getWishlistProducts() {
    final jsonList = _prefs.getStringList(_wishlistKey) ?? [];

    try {
      return jsonList
          .map((e) => WishlistModel.fromJson(jsonDecode(e)))
          .toList();
    } catch (e) {
      _prefs.remove(_wishlistKey);
      return [];
    }
  }

  /// Clear wishlist
  Future<void> clearWishlistProducts() async {
    await _prefs.remove(_wishlistKey);
  }

  /// Save recent search
  Future<void> saveRecentSearch(String search) async {
    final recentSearch = _prefs.getStringList(_recentSearchKey) ?? [];

    if (recentSearch.contains(search)) {
      recentSearch.remove(search);
    }
    recentSearch.add(search);

    if (recentSearch.length > 5) {
      recentSearch.removeAt(0);
    }

    await _prefs.setStringList(_recentSearchKey, recentSearch);
  }

  /// Get recent search
  List<String> getRecentSearch() {
    return _prefs.getStringList(_recentSearchKey) ?? [];
  }

  /// Clear recent search
  Future<void> clearRecentSearch() async {
    await _prefs.remove(_recentSearchKey);
  }
}
