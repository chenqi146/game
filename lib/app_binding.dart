
import 'package:game/api/room_repository.dart';
import 'package:game/api/user_repository.dart';
import 'package:game/app_constants.dart';
import 'package:game/common/http_client.dart';
import 'package:game/common/http_config.dart';
import 'package:game/common/http_interceptor.dart';
import 'package:game/service/room_service.dart';
import 'package:game/service/user_service.dart';
import 'package:get/get.dart';

///异步注入构造方法中的对象 用于Api网络请求相关的注入
///主要是在App初始化的时候就注入到依赖注入的池里面，并单例持久化
class AppBinding extends Bindings {
  @override
  void dependencies() async {
    // Get.put(ApiProvider(), permanent: true);

    HttpConfig dioConfig = HttpConfig(
        baseUrl: ApiConstants.baseUrl,
        interceptors: [UserIdInterceptor()]);
    Get.put(HttpClient(), permanent: true);

    Get.put(RoomRepository(httpClient: Get.find()));
    Get.put(UserRepository(httpClient: Get.find()));

    // 用户信息服务（用户信息相关业务类）
    Get.put(UserService(userRepository: Get.find()));
    Get.put(RoomService(repository: Get.find()));


  }
}
