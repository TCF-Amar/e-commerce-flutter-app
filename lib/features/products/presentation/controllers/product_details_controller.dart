import 'dart:developer' as developer;

import 'package:flutter_e_commerce/features/products/domain/entity/product.dart';
import 'package:flutter_e_commerce/features/products/domain/usecases/product_usecases.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final ProductsUseCase productsUseCase;
  final String slug;

  ProductDetailsController({required this.slug, required this.productsUseCase});

  final Rxn<Product> _product = Rxn<Product>();
  Product? get product => _product.value;

  final Rxn<List<Product>> _relatedProducts = Rxn<List<Product>>();
  List<Product>? get relatedProducts => _relatedProducts.value;

  final RxInt currentImageIndex = 0.obs;
  final RxString selectedSize = ''.obs;
  final RxInt selectedQuantity = 1.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    clear();
    fetchSingleProductBySlug(slug);
    fetchRelatedProducts(slug);
  }

  Future<void> fetchSingleProductBySlug(String slug) async {
    isLoading.value = true;
    final result = await productsUseCase.getSingleProductBySlug(slug);
    result.fold(
      (failure) {
        developer.log(failure.message, name: 'fetchSingleProductBySlug');
      },
      (product) {
        _product.value = product;
      },
    );
    isLoading.value = false;
  }

  Future<void> fetchRelatedProducts(String slug) async {
    isLoading.value = true;
    final result = await productsUseCase.getRelatedProducts(slug);
    result.fold(
      (failure) {
        developer.log(failure.message, name: 'fetchRelatedProducts');
      },
      (products) {
        _relatedProducts.value = products;
      },
    );
    isLoading.value = false;
  }

  void clear() {
    _product.value = null;
    _relatedProducts.value = null;
    currentImageIndex.value = 0;
    selectedSize.value = '';
    selectedQuantity.value = 1;
  }
}
