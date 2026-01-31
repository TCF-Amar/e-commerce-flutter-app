import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/manager/auth_session_manager.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/manager/auth_state.dart';
import 'package:flutter_e_commerce/core/utils/product_sort_util.dart';
import 'package:flutter_e_commerce/features/products/domain/entity/product.dart';
import 'package:flutter_e_commerce/features/products/domain/usecases/product_usecases.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final _products = <Product>[].obs;
  List<Product> get products => _products;

  final isLoading = false.obs;
  final isMoreLoading = false.obs;

  final currentSort = ProductSort.relative.obs;

  void sortProducts(ProductSort sort) {
    currentSort.value = sort;
    ProductSortUtil.sortProducts(_products, sort);
    _products.refresh();
  }

  // Pagination vars
  int _offset = 0;
  final int _limit = 10;
  bool _hasMore = true;

  int? _categoryId;
  String _title = '';
  int? _priceMin;
  int? _priceMax;

  int? get categoryId => _categoryId;
  int? get priceMin => _priceMin;
  int? get priceMax => _priceMax;

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  final ProductsUseCase productsUseCase;
  final AuthSessionManager authSessionManager;

  ProductController({
    required this.productsUseCase,
    required this.authSessionManager,
  });

  @override
  void onInit() {
    super.onInit();
    _checkAuthAndFetch();
    authSessionManager.addListener(_authListener);
    _scrollController.addListener(_scrollListener);
  }

  void _authListener() {
    if (authSessionManager.status != AuthStatus.unknown &&
        authSessionManager.status != AuthStatus.unauthenticated) {
      if (_products.isEmpty && !isLoading.value) {
        fetchProducts();
      }
    }
  }

  void init() {
    if (_products.isEmpty && !isLoading.value) {
      resetFilters();
    }
  }

  void _checkAuthAndFetch() {
    if (authSessionManager.status != AuthStatus.unknown &&
        authSessionManager.status != AuthStatus.unauthenticated) {
      fetchProducts();
    }
  }

  void _scrollListener() {
    if (_scrollController.hasClients &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !isMoreLoading.value &&
        !isLoading.value &&
        _hasMore) {
      loadMore();
    }
  }

  bool get hasMore => _hasMore;

  Future<void> fetchProducts() async {
    if (isLoading.value) return;
    isLoading.value = true;
    _offset = 0;
    _hasMore = true;
    final result = await productsUseCase.getProducts(
      offset: _offset,
      limit: _limit,
      categoryId: _categoryId,
      title: _title.isEmpty ? null : _title,
      priceMin: _priceMin,
      priceMax: _priceMax,
    );

    result.fold(
      (failure) {
        developer.log(failure.message, name: 'fetchProducts');
      },
      (newProducts) {
        if (newProducts.length < _limit) _hasMore = false;
        _products.assignAll(newProducts);
        _offset += _limit;
        developer.log(_products.length.toString(), name: 'fetchProducts');
      },
    );
    isLoading.value = false;
  }

  Future<void> loadMore() async {
    if (isLoading.value || isMoreLoading.value || !_hasMore) return;
    isMoreLoading.value = true;
    final result = await productsUseCase.getProducts(
      offset: _offset,
      limit: _limit,
      categoryId: _categoryId,
      title: _title.isEmpty ? null : _title,
      priceMin: _priceMin,
      priceMax: _priceMax,
    );

    result.fold(
      (failure) {
        developer.log(failure.message, name: 'loadMoreProducts');
      },
      (newProducts) {
        if (newProducts.length < _limit) _hasMore = false;
        _products.addAll(newProducts);
        _offset += _limit;
        developer.log(_products.length.toString(), name: 'fetchProducts');
      },
    );
    isMoreLoading.value = false;
  }



  void applyFilters({
    int? categoryId,
    String? title,
    int? priceMin,
    int? priceMax,
  }) {
    _categoryId = categoryId;
    if (title != null) _title = title;
    _priceMin = priceMin;
    _priceMax = priceMax;
    fetchProducts();
  }

  Future<void> resetFilters() async {
    _categoryId = null;
    _title = '';
    _priceMin = null;
    _priceMax = null;
    await fetchProducts();
  }

 

  

  @override
  void onClose() {
    _scrollController.dispose();
    super.onClose();
  }
}
