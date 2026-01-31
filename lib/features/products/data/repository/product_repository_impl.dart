import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce/core/error/failure.dart';
import 'package:flutter_e_commerce/core/error/failure_type.dart';
import 'package:flutter_e_commerce/core/network/exceptions/api_exceptions.dart';
import 'package:flutter_e_commerce/core/network/exceptions/exceptions.dart';
import 'package:flutter_e_commerce/features/products/domain/entity/category.dart';
import 'package:flutter_e_commerce/features/products/domain/entity/product.dart';
import 'package:flutter_e_commerce/features/products/data/datasource/product_remote_datasource.dart';
import 'package:flutter_e_commerce/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDatasource;

  ProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    int offset = 0,
    int limit = 10,
    int? categoryId,
    String? title,
    int? priceMin,
    int? priceMax,
  }) async {
    try {
      final result = await remoteDatasource.getProducts(
        offset: offset,
        limit: limit,
        categoryId: categoryId,
        title: title,
        priceMin: priceMin,
        priceMax: priceMax,
      );

      return Right(result);
    } on AppException catch (e) {
      return Left(ApiException.map(e));
    } catch (_) {
      return Left(
        Failure(type: FailureType.unknown, message: 'Something went wrong'),
      );
    }
  }

  @override
  Future<Either<Failure, Product>> getSingleProductBySlug(String slug) async {
    try {
      final result = await remoteDatasource.getSingleProductBySlug(slug);
      return Right(result);
    } on AppException catch (e) {
      return Left(ApiException.map(e));
    } catch (_) {
      return Left(
        Failure(type: FailureType.unknown, message: 'Something went wrong'),
      );
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getRelatedProducts(String slug) async {
    try {
      final result = await remoteDatasource.getRelatedProducts(slug);
      return Right(result);
    } on AppException catch (e) {
      return Left(ApiException.map(e));
    } catch (_) {
      return Left(
        Failure(type: FailureType.unknown, message: 'Something went wrong'),
      );
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final result = await remoteDatasource.getCategories();
      return Right(result);
    } on AppException catch (e) {
      return Left(ApiException.map(e));
    } catch (_) {
      return Left(
        Failure(type: FailureType.unknown, message: 'Something went wrong'),
      );
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategoryId(
    String category,
  ) async {
    try {
      final result = await remoteDatasource.getProductsByCategoryId(category);
      return Right(result);
    } on AppException catch (e) {
      return Left(ApiException.map(e));
    } catch (_) {
      return Left(
        Failure(type: FailureType.unknown, message: 'Something went wrong'),
      );
    }
  }
}
