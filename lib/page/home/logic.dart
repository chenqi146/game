import 'package:game/service/user_service.dart';
import 'package:game/service/ws_service.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {

  final UserService userService = Get.find();
  final WebsocketService websocketService = Get.find();

  updateUserInfo(String nickName, String avatar) async {
    UserService.to.updateUserInfo(nickName, avatar);
  }

  Future<void> initUser() {
    return userService.initUser();
  }

}
