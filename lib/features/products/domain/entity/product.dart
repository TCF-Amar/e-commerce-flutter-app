import 'package:equatable/equatable.dart';
import 'package:flutter_e_commerce/features/products/domain/entity/category.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String slug;
  final double price;
  final String description;
  final Category category;
  final List<String> images;
  final bool? trending;
  

  const Product({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    this.trending = false,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    slug,
    price,
    description,
    category,
    images,
    trending,
  ];
}
