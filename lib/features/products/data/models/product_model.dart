import 'package:flutter_e_commerce/features/products/data/models/category_model.dart';
import 'package:flutter_e_commerce/features/products/domain/entity/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.price,
    required super.description,
    required super.category,
    required super.images,
    required super.trending,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
    title: json['title'] ?? '',
    slug: json['slug'] ?? '',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    description: json['description'] ?? '',
    category: CategoryModel.fromJson(json['category']),
    images: List<String>.from(json['images'] ?? []),
    trending: json['trending'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'slug': slug,
    'price': price,
    'description': description,
    'category': (category as CategoryModel).toJson(),
    'images': images,
    'trending': trending,
  };

  // entity
  Product toEntity() => Product(
    id: id,
    title: title,
    slug: slug,
    price: price,
    description: description,
    category: category,
    images: images,
    trending: trending,
  );
}
