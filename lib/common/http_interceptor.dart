

import 'package:dio/dio.dart';

class UserIdInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers['Authorization'] = 'Bearer ${Get.find<UserController>().user?.token}';

    super.onRequest(options, handler);
  }
}