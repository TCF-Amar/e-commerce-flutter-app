import 'package:flutter_e_commerce/features/products/domain/entity/product.dart';

enum ProductSort {
  relative,
  trending,
  priceLowToHigh,
  priceHighToLow,
  aToZ,
  zToA,
}

class ProductSortUtil {
  static List<Product> sortProducts(List<Product> products, ProductSort sort) {
    switch (sort) {
      case ProductSort.relative:
        products.sort((a, b) => a.id.compareTo(b.id));
        return products;
      case ProductSort.trending:
        products.sort((a, b) => b.id.compareTo(a.id));
        return products;

      case ProductSort.priceLowToHigh:
        products.sort((a, b) => a.price.compareTo(b.price));
        return products;
      case ProductSort.priceHighToLow:
        products.sort((a, b) => b.price.compareTo(a.price));
        return products;
      case ProductSort.aToZ:
        products.sort((a, b) => a.title.compareTo(b.title));
        return products;
      case ProductSort.zToA:
        products.sort((a, b) => b.title.compareTo(a.title));
        return products;
    }
  }
}
