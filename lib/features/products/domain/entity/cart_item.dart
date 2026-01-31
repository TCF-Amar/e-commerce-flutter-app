import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int id;
  final String slug;
  final String title;
  final String image;
  final double price;
  final int quantity;
  final String size;

  const CartItem({
    required this.id,
    required this.slug,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
    required this.size,

  });

  @override
  List<Object?> get props => [id, slug, title, image, price, quantity, size];
}
