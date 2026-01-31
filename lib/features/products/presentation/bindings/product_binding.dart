import 'package:flutter_e_commerce/features/auth/presentation/controllers/manager/auth_session_manager.dart';
import 'package:flutter_e_commerce/features/products/data/datasource/product_remote_datasource.dart';
import 'package:flutter_e_commerce/features/products/data/datasource/product_remote_datasource_impl.dart';
import 'package:flutter_e_commerce/features/products/data/repository/product_repository_impl.dart';
import 'package:flutter_e_commerce/features/products/domain/repository/product_repository.dart';
import 'package:flutter_e_commerce/features/products/domain/usecases/product_usecases.dart';
import 'package:flutter_e_commerce/features/products/presentation/controllers/product_category_controller.dart';
import 'package:flutter_e_commerce/features/products/presentation/controllers/product_controller.dart';
import 'package:flutter_e_commerce/features/products/presentation/controllers/product_search_controller.dart';
import 'package:get/get.dart';

class ProductBinding {
  static void init() {
    //! datasource
    Get.put<ProductRemoteDatasource>(
      ProductRemoteDatasourceImpl(Get.find()),
      permanent: true,
    );

    //! repository
    Get.put<ProductRepository>(
      ProductRepositoryImpl(Get.find()),
      permanent: true,
    );

    //! usecases
    Get.put<ProductsUseCase>(ProductsUseCase(Get.find()), permanent: true);

    //! controllers
    Get.put(
      ProductController(
        productsUseCase: Get.find<ProductsUseCase>(),
        authSessionManager: Get.find<AuthSessionManager>(),
      ),
      permanent: true,
    );
    Get.put(
      ProductCategoryController(
        productsUseCase: Get.find<ProductsUseCase>(),
        authSessionManager: Get.find<AuthSessionManager>(),
      ),
      permanent: true,
    );
    Get.lazyPut(
      () => ProductSearchController(
        productsUseCase: Get.find<ProductsUseCase>(),
        authSessionManager: Get.find<AuthSessionManager>(),
      ),
      fenix: true,
    );
  }

  // static void productCategoryController() {
  //   Get.put(
  //     ProductCategoryController(
  //       getProductsUseCase: Get.find(),
  //       authSessionManager: Get.find<AuthSessionManager>(),
  //     ),
  //     permanent: true,
  //   );
  // }
}
