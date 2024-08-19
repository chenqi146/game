

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';

class UserIdInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers['Authorization'] = 'Bearer ${Get.find<UserController>().user?.token}';
    options.headers['X-UserId'] = SpUtil.getInt('userId').toString();

    super.onRequest(options, handler);
  }
}