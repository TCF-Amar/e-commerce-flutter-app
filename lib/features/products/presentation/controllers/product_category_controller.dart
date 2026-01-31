import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/utils/product_sort_util.dart';

import 'package:flutter_e_commerce/features/products/domain/entity/category.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/manager/auth_session_manager.dart';
import 'package:flutter_e_commerce/features/auth/presentation/controllers/manager/auth_state.dart';
import 'package:flutter_e_commerce/features/products/domain/usecases/product_usecases.dart';
import 'package:flutter_e_commerce/features/products/presentation/controllers/product_controller.dart';
import 'package:get/get.dart';

class ProductCategoryController extends GetxController {
  final ProductsUseCase productsUseCase;
  final AuthSessionManager authSessionManager;

  ProductCategoryController({
    required this.productsUseCase,
    required this.authSessionManager,
  });

  final _categories = <Category>[].obs;
  List<Category> get categories => _categories;
  final isLoading = false.obs;

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  ProductController get _productController => Get.find<ProductController>();

  @override
  void onInit() {
    super.onInit();
    _checkAuthAndFetch();
    authSessionManager.addListener(_authListener);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.hasClients &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      _productController.loadMore();
    }
  }

  void _authListener() {
    if (authSessionManager.status != AuthStatus.unknown &&
        authSessionManager.status != AuthStatus.unauthenticated) {
      if (_categories.isEmpty && !isLoading.value) {
        getCategories();
      }
    }
  }

  void _checkAuthAndFetch() {
    if (authSessionManager.status != AuthStatus.unknown &&
        authSessionManager.status != AuthStatus.unauthenticated) {
      getCategories();
    }
  }

  @override
  void onClose() {
    authSessionManager.removeListener(_authListener);
    _scrollController.dispose();
    super.onClose();
  }

  Future<void> getCategories() async {
    isLoading.value = true;
    final result = await productsUseCase.getCategories();
    result.fold(
      (l) {
        developer.log(l.message, name: 'getCategories');
      },
      (r) {
        _categories.value = r;
        developer.log(r.length.toString(), name: 'getCategories');
      },
    );
    isLoading.value = false;
  }

  final Rxn<int> selectedCategoryId = Rxn<int>();

  // Delegate filter getters to ProductController
  int? get priceMin => _productController.priceMin;
  int? get priceMax => _productController.priceMax;

  final currentSort = ProductSort.relative.obs;

  void initCategory(int? categoryId) {
    if (selectedCategoryId.value == categoryId) return;
    selectCategory(categoryId);
  }

  void selectCategory(int? id) {
    selectedCategoryId.value = id;
    _productController.applyFilters(categoryId: id);
  }

  void applyFilters({
    int? categoryId,
    String? title,
    int? priceMin,
    int? priceMax,
  }) {
    if (categoryId != null) selectedCategoryId.value = categoryId;
    _productController.applyFilters(
      categoryId: selectedCategoryId.value,
      title: title,
      priceMin: priceMin,
      priceMax: priceMax,
    );
  }

  void resetFilters() {
    selectedCategoryId.value = null;
    currentSort.value = ProductSort.relative;
    _productController.resetFilters();
  }

  void sortProducts(ProductSort sort) {
    currentSort.value = sort;
    _productController.sortProducts(sort);
  }
}
