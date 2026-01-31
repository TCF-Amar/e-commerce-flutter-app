import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/storage/product_storage.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/manager/auth_session_manager.dart';
import 'package:flutter_e_commerce/features/products/domain/entity/product.dart';
import 'package:flutter_e_commerce/features/products/domain/usecases/product_usecases.dart';
import 'package:flutter_e_commerce/features/products/presentation/controllers/product_controller.dart';
import 'package:get/get.dart';

class ProductSearchController extends GetxController {
  final ProductsUseCase productsUseCase;

  ProductSearchController({
    required this.productsUseCase,
    required AuthSessionManager authSessionManager,
  });

  final productController = Get.find<ProductController>();
  final productStorage = Get.find<ProductStorage>();
  final isLoading = false.obs;
  final isMoreLoading = false.obs;

  final _products = <Product>[].obs;
  List<Product> get products => _products;

  final _offset = 0.obs;
  final _limit = 20.obs;
  final _hasMore = true.obs;

  final _recentSearches = <String>[].obs;
  List<String> get recentSearches => _recentSearches;

  final ScrollController scrollController = ScrollController();
  final queryController = TextEditingController();
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    loadRecentSearches();
    queryController.addListener(_queryListener);
    scrollController.addListener(_scrollListener);
  }

  void loadRecentSearches() {
    _recentSearches.assignAll(productStorage.getRecentSearch());
  }

  Future<void> clearRecentSearches() async {
    await productStorage.clearRecentSearch();
    loadRecentSearches();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    queryController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void _queryListener() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (queryController.text.isNotEmpty) {
        fetchProducts();
      } else {
        _products.clear();
      }
    });
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      fetchMoreProducts();
    }
  }

  Future<void> fetchProducts() async {
    if (isLoading.value) return;

    final query = queryController.text.trim();
    if (query.isNotEmpty) {
      await productStorage.saveRecentSearch(query);
      loadRecentSearches();
    }

    isLoading.value = true;
    _offset.value = 0;
    _hasMore.value = true;
    final result = await productsUseCase.getProducts(
      offset: _offset.value,
      limit: _limit.value,
      title: query,
    );

    result.fold(
      (failure) {
        developer.log(failure.message, name: 'Search');
      },
      (newProducts) {
        if (newProducts.length < _limit.value) _hasMore.value = false;
        _products.assignAll(newProducts);
        _offset.value += _limit.value;
        developer.log(_products.length.toString(), name: 'Search');
      },
    );
    isLoading.value = false;
  }

  Future<void> fetchMoreProducts() async {
    if (isMoreLoading.value || !_hasMore.value) return;
    isMoreLoading.value = true;
    final result = await productsUseCase.getProducts(
      offset: _offset.value,
      limit: _limit.value,
      title: queryController.text.trim(),
    );

    result.fold(
      (failure) {
        developer.log(failure.message, name: 'Search');
      },
      (newProducts) {
        if (newProducts.length < _limit.value) _hasMore.value = false;
        _products.addAll(newProducts);
        _offset.value += _limit.value;
        developer.log(_products.length.toString(), name: 'Search');
      },
    );
    isMoreLoading.value = false;
  }
}
