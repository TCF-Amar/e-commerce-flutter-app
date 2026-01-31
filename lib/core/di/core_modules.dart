import 'package:flutter_e_commerce/core/db/cart_database.dart';
import 'package:flutter_e_commerce/core/storage/cart_storage.dart';
import 'package:flutter_e_commerce/core/storage/product_storage.dart';
import 'package:flutter_e_commerce/core/storage/token_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreModules {
  static Future<void> init() async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    Get.put<TokenStorage>(TokenStorage(storage), permanent: true);
    Get.put<ProductStorage>(ProductStorage(sharedPreferences), permanent: true);
    Get.put<CartStorage>(
      CartStorage(prefs: sharedPreferences),
      permanent: true,
    );
    Get.put<CartDatabase>(CartDatabase.instance, permanent: true);
  }
}
