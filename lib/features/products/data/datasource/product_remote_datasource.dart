import 'package:flutter_e_commerce/features/products/data/models/category_model.dart';
import 'package:flutter_e_commerce/features/products/data/models/product_model.dart';

abstract class ProductRemoteDatasource {
  /// fetches products from the remote server
  /// expect return list of [ProductModel]
  Future<List<ProductModel>> getProducts({
    int offset = 0,
    int limit = 10,
    int? categoryId,
    String? title,
    int? priceMin,
    int? priceMax,
  });

  Future<ProductModel> getSingleProductBySlug(String slug);

  Future<List<ProductModel>> getRelatedProducts(String slug);

  Future<List<CategoryModel>> getCategories();

  Future<List<ProductModel>> getProductsByCategoryId(String category);
}
