import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:game/common/base/base_stateful_page.dart';
import 'package:game/common/utils/utils.dart';
import 'package:game/components/icon_avatar.dart';
import 'package:game/service/user_service.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomePage extends BaseStatefulPage<HomeLogic> {
  HomePage({Key? key}) : super(key: key);

  @override
  HomeLogic createRawLogic() {
    return HomeLogic();
  }

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: FutureBuilder(
        future: widget.logic.initUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Stack(
                  children: [
                    const Column(
                      children: [
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            // '游戏大厅',
                            'XXXX',
                            style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0), // 添加 Padding
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Obx(() => PlayerAvatar(
                          avatarUrl: UserService.to.getAvatarUrl(),
                          playerName: UserService.to.getNickName,
                          onTap: _onAvatarTap,
                          selectedOverlay: Container(
                            width: 48.0,
                            height: 48.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.amber,
                        minWidth: 40,
                        height: 50,
                        onPressed: () {
                          Navigator.pushNamed(context, '/undercover');
                        },
                        child: const Text('我是卧底')),
                  ],
                ),
                const SizedBox(height: 84),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _onAvatarTap() {
    _showUserDialog();
  }

  void _showUserDialog() {
    SmartDialog.show(
        usePenetrate: false,
        keepSingle: true,
        builder: (_) {
          final TextEditingController controller =
              TextEditingController(text: UserService.to.getNickName);

          Rx<String> avatar = UserService.to.getAvatarUrl().obs;
          Rx<String> avatarSource = UserService.to.getAvatar.obs;
          return Container(
              width: 300,
              height: 360,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(height: 36),
                    Obx(() => IconButton(
                        onPressed: () {
                          // 点击切换头像
                          avatarSource.value =
                              UserService.to.getDefaultAvatar();
                          avatar.value = Utils.getAvatarUrl(avatarSource.value);
                        },
                        iconSize: 10,
                        icon: Container(
                          width: 128.0, // 设置外部容器的宽度
                          height: 128.0, // 设置外部容器的高度
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black, // 边框颜色
                              width: 3.0, // 将边框宽度从 1.0 增加到 3.0
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(avatar.value),
                            radius: 20,
                          ),
                        ))),
                    // 输入框
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const Text('昵称:'),
                        // const SizedBox(width: 10),
                        Container(
                          width: 160,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            // 默认值
                            controller: controller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 10, bottom: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            // 背景颜色
                            foregroundColor: Colors.white,
                            // 文字颜色
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 16),
                            textStyle: const TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // 圆角
                            ),
                          ),
                          onPressed: () => (_saveUserInfo(
                              controller.text, avatarSource.value)),
                          child: const Text('确认'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                  ],
                ),
              ));
        });
  }

  @override
  void initState() {
    super.initState();
  }

  _saveUserInfo(String nickName, String avatar) {
    widget.logic.updateUserInfo(
      nickName,
      avatar,
    );
    SmartDialog.dismiss();
  }
}
