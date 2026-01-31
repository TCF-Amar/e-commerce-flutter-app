import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce/core/error/failure.dart';
import 'package:flutter_e_commerce/features/products/domain/entity/category.dart';
import 'package:flutter_e_commerce/features/products/domain/entity/product.dart';

abstract class ProductRepository {
  /// fetches products from the remote server
  /// expect return list of [Product]
  Future<Either<Failure, List<Product>>> getProducts({
    int offset = 0,
    int limit = 10,
    int? categoryId,
    String? title,
    int? priceMin,
    int? priceMax,
  });

  Future<Either<Failure, Product>> getSingleProductBySlug(String slug);

  Future<Either<Failure, List<Product>>> getRelatedProducts(String slug);

  Future<Either<Failure, List<Category>>> getCategories();

  Future<Either<Failure, List<Product>>> getProductsByCategoryId(
    String category,
  );
}
