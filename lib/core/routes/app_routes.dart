import 'package:equatable/equatable.dart';

class RouteModel extends Equatable {
  final String name;
  final String path;

  const RouteModel({required this.name, required this.path});

  @override
  List<Object?> get props => [name, path];
}

class AppRoutes {
  static final splash = const RouteModel(name: 'splash', path: '/splash');
  static final login = const RouteModel(name: 'login', path: '/login');
  static final register = const RouteModel(name: 'register', path: '/register');
  static final dashboard = const RouteModel(
    name: 'dashboard',
    path: '/dashboard',
  );
  static final search = const RouteModel(name: 'search', path: '/search');

  static final category = const RouteModel(name: 'category', path: '/category');
  static final wishlist = const RouteModel(name: 'wishlist', path: '/wishlist');
  static final cart = const RouteModel(name: 'cart', path: '/cart');
  static final productDetails = const RouteModel(
    name: 'productDetails',
    path: '/productDetails',
  );
}
