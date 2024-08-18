import 'package:game/service/user_service.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {

  // 控制用户信息弹窗是否出现
  var isShowUserInfoDialog = false.obs;

  updateUserInfo(String nickName, String avatar) async {
    UserService.to.updateUserInfo(nickName, avatar);
  }

}
