import 'package:game/service/user_service.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {

  updateUserInfo(String nickName, String avatar) async {
    UserService.to.updateUserInfo(nickName, avatar);
  }

}
