

import 'package:english_words/english_words.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:game/api/user_repository.dart';
import 'package:game/common/http_config.dart';
import 'package:get/get.dart';

class UserService extends GetxService {

  static UserService to = Get.find();

  final UserRepository userRepository;

  UserService({required this.userRepository});

  Rx<int> userId = 0.obs;
  Rx<String> nickName = "".obs;

  int get getUserId => userId.value;
  String get getNickName => nickName.value;


  @override
  void onInit() async {
    int? userId = SpUtil.getInt("userId");
    if (userId == null || userId <= 0) {
      // 创建一个用户
      SmartDialog.showLoading();
      var nickName = WordPair.random().asCamelCase;
      R<int> r = await userRepository.createUser(nickName, "");
      SmartDialog.dismiss(status: SmartStatus.loading);
      if (r.ok) {
        userId = r.data;
        this.userId.value = userId!;
        this.nickName.value = nickName;
        SpUtil.putInt("userId", userId);
        SpUtil.putString("nickName", nickName);
      } else {
        SmartDialog.showToast(r.error?.message ?? "创建用户失败");
      }
    } else {
      this.userId.value = userId;
      nickName.value = SpUtil.getString("nickName")!;
    }
    super.onInit();
  }


}