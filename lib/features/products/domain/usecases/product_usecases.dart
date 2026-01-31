import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce/core/error/failure.dart';
import 'package:flutter_e_commerce/features/products/domain/entity/category.dart';
import 'package:flutter_e_commerce/features/products/domain/entity/product.dart';
import 'package:flutter_e_commerce/features/products/domain/repository/product_repository.dart';

class ProductsUseCase {
  final ProductRepository repository;

  ProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> getProducts({
    int offset = 0,
    int limit = 10,
    int? categoryId,
    String? title,
    int? priceMin,
    int? priceMax,
  }) async {
    return await repository.getProducts(
      offset: offset,
      limit: limit,
      categoryId: categoryId,
      title: title,
      priceMin: priceMin,
      priceMax: priceMax,
    );
  }

  Future<Either<Failure, Product>> getSingleProductBySlug(String slug) async {
    return await repository.getSingleProductBySlug(slug);
  }

  Future<Either<Failure, List<Product>>> getRelatedProducts(String slug) async {
    return await repository.getRelatedProducts(slug);
  }

  Future<Either<Failure, List<Category>>> getCategories() async {
    return await repository.getCategories();
  }

  Future<Either<Failure, List<Product>>> getProductsByCategoryId(
    String category,
  ) async {
    return await repository.getProductsByCategoryId(category);
  }
}
