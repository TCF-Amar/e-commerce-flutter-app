import 'package:flutter_e_commerce/features/products/domain/entity/cart_item.dart';

final String tableCart = 'cart';

class CartFields {
  static const String id = '_id';
  static const String slug = 'slug';
  static const String title = 'title';
  static const String image = 'image';
  static const String price = 'price';
  static const String quantity = 'quantity';
  static const String size = 'size';
}

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.id,
    required super.slug,
    required super.title,
    required super.image,
    required super.price,
    required super.quantity,
    required super.size,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json[CartFields.id] as int? ?? json['id'] as int,
      slug: json[CartFields.slug] as String,
      title: json[CartFields.title] as String,
      image: json[CartFields.image] as String,
      price: (json[CartFields.price] as num).toDouble(),
      quantity: json[CartFields.quantity] as int,
      size: json[CartFields.size] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      CartFields.id: id,
      CartFields.slug: slug,
      CartFields.title: title,
      CartFields.image: image,
      CartFields.price: price,
      CartFields.quantity: quantity,
      CartFields.size: size,
    };
  }

  CartItemModel copyWith({
    int? id,
    String? slug,
    String? title,
    String? image,
    double? price,
    int? quantity,
    String? size,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
    );
  }
}
