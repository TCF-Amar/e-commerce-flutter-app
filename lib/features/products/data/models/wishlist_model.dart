import 'package:equatable/equatable.dart';
import 'package:flutter_e_commerce/features/products/domain/entity/category.dart';
import 'package:flutter_e_commerce/features/products/domain/entity/product.dart';

class WishlistModel extends Equatable {
  final int id;
  final String slug;
  final String title;
  final double price;
  final String image;

  const WishlistModel({
    required this.id,
    required this.slug,
    required this.title,
    required this.price,
    required this.image,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['id'],
      slug: json['slug'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'title': title,
      'price': price,
      'image': image,
    };
  }

  @override
  List<Object?> get props => [id, slug, title, price, image];

  Product toProduct() {
    return Product(
      id: id,
      title: title,
      slug: slug,
      price: price,
      description: "",
      category: const Category(id: 0, name: "", image: "", slug: ''),
      images: [image],
    );
  }
}
