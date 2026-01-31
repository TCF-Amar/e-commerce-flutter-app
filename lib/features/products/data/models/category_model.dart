import 'package:flutter_e_commerce/features/products/domain/entity/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
    name: json['name'] ?? '',
    slug: json['slug'] ?? '',
    image: json['image'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'image': image,
  };

  // entity
  Category toEntity() => Category(id: id, name: name, slug: slug, image: image);
}
