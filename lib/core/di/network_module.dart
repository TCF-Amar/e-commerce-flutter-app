import 'package:flutter_e_commerce/core/network/dio_helper.dart';
import 'package:get/get.dart';

import '../network/dio_client.dart';

class NetworkModule {
  static void init() {
    // Initialize network-related dependencies here
    Get.lazyPut<DioClient>(() => DioClient(), fenix: true);

    Get.lazyPut<DioHelper>(() => DioHelper(Get.find<DioClient>()), fenix: true);
  }
}
