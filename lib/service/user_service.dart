

import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:game/api/user_repository.dart';
import 'package:game/common/http_config.dart';
import 'package:game/common/utils/utils.dart';
import 'package:get/get.dart';

class UserService extends GetxService {

  static UserService to = Get.find();

  final UserRepository userRepository;

  UserService({required this.userRepository});

  Rx<int> userId = 0.obs;
  Rx<String> nickName = "".obs;
  Rx<String> avatar = "".obs;

  int get getUserId => userId.value;
  String get getNickName => nickName.value;
  String get getAvatar => avatar.value;


  @override
  void onInit() async {

    SpUtil.putInt("userId", 1);
    SpUtil.putString("nickName", "cq");
    SpUtil.putString("avatar", "avataaars1");
    this.userId.value = 1;
    this.nickName.value = "cq";
    this.avatar.value = "avataaars1";

    // int? userId = SpUtil.getInt("userId");
    // if (userId == null || userId <= 0) {
    //   // 创建一个用户
    //   SmartDialog.showLoading();
    //   var nickName = WordPair.random().asCamelCase;
    //   var avatar = getDefaultAvatar();
    //   R<int> r = await userRepository.createUser(nickName, avatar);
    //   SmartDialog.dismiss(status: SmartStatus.loading);
    //   if (r.ok) {
    //     userId = r.data;
    //     this.userId.value = userId!;
    //     this.nickName.value = nickName;
    //     this.avatar.value = avatar;
    //     SpUtil.putInt("userId", userId);
    //     SpUtil.putString("nickName", nickName);
    //     SpUtil.putString("avatar", avatar);
    //   } else {
    //     SmartDialog.showToast(r.error?.message ?? "创建用户失败");
    //   }
    // } else {
    //   this.userId.value = userId;
    //   nickName.value = SpUtil.getString("nickName")!;
    //   avatar.value = SpUtil.getString("avatar")!;
    // }
    super.onInit();
  }

  updateUserInfo(String nickName, String avatar) async {

    // var userId = SpUtil.getInt("userId");
    // R<void> res = await userRepository.updateUser(userId!, nickName, avatar);
    // if (!res.ok) {
    //   SmartDialog.showToast(res.error?.message ?? "更新用户信息失败");
    //   return;
    // }
    //
    this.nickName.value = nickName;
    this.avatar.value = avatar;
    SpUtil.putString("nickName", nickName);
    SpUtil.putString("avatar", avatar);
  }

  String getAvatarUrl() {
    return Utils.getAvatarUrl(getAvatar);
  }

  // 获取一个随机头像
  String getDefaultAvatar() {
    // 读取assets目录下的所有头像
    List<String> avatars = [
      "avataaars1",
      "avataaars2",
      "avataaars3",
      "avataaars4",
      "avataaars5",
      "avataaars6",
      "avataaars7",
      "avataaars8",
    ];
    return avatars[Random().nextInt(avatars.length)];
  }


}