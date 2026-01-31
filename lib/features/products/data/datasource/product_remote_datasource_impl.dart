import 'package:flutter_e_commerce/core/constants/api_end_points.dart';
import 'package:flutter_e_commerce/core/error/handel_error_response.dart';
import 'package:flutter_e_commerce/core/network/dio_helper.dart';
import 'package:flutter_e_commerce/features/products/data/datasource/product_remote_datasource.dart';
import 'package:flutter_e_commerce/features/products/data/models/category_model.dart';
import 'package:flutter_e_commerce/features/products/data/models/product_model.dart';

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final DioHelper dioHelper;
  ProductRemoteDatasourceImpl(this.dioHelper);

  @override
  Future<List<ProductModel>> getProducts({
    int offset = 0,
    int limit = 10,
    int? categoryId,
    String? title,
    int? priceMin,
    int? priceMax,
  }) async {
    final response = await dioHelper.request(
      ApiRequest(
        url: ApiEndpoints.products,
        method: ApiMethod.get,
        queryParameters: {
          'offset': offset,
          'limit': limit,
          if (categoryId != null) 'categoryId': categoryId,
          if (title != null) 'title': title,
          if (priceMin != null) 'price_min': priceMin,
          if (priceMax != null) 'price_max': priceMax,
        },
      ),
    );

    HandleErrorResponse.handle(response.data);
    if (response.data is List) {
      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    }

    return [];
  }

  @override
  Future<ProductModel> getSingleProductBySlug(String slug) async {
    final response = await dioHelper.request(
      ApiRequest(url: ApiEndpoints.productBySlug(slug), method: ApiMethod.get),
    );

    HandleErrorResponse.handle(response.data);
    return ProductModel.fromJson(response.data);
  }

  @override
  Future<List<ProductModel>> getRelatedProducts(String slug) async {
    final response = await dioHelper.request(
      ApiRequest(url: ApiEndpoints.relatedProduct(slug), method: ApiMethod.get),
    );

    HandleErrorResponse.handle(response.data);
    if (response.data is List) {
      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    }
    return [];
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await dioHelper.request(
      ApiRequest(url: ApiEndpoints.categories, method: ApiMethod.get),
    );

    HandleErrorResponse.handle(response.data);
    if (response.data is List) {
      return (response.data as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();
    }
    return [];
  }

  @override
  Future<List<ProductModel>> getProductsByCategoryId(String category) async {
    final response = await dioHelper.request(
      ApiRequest(
        url: ApiEndpoints.productsByCategoryId(category),
        method: ApiMethod.get,
      ),
    );

    HandleErrorResponse.handle(response.data);
    if (response.data is List) {
      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
