import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:game/common/base/base_stateful_page.dart';
import 'package:game/service/user_service.dart';

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
      body: Column(
        children: [
          Stack(
            children: [
              const Column(
                children: [
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '游戏大厅',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          _showUserDialog();
                        },
                        iconSize: 10,
                        icon: Container(
                          width: 48.0, // 设置外部容器的宽度
                          height: 48.0, // 设置外部容器的高度
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black, // 边框颜色
                              width: 1.0, // 边框宽度
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                AssetImage('assets/images/gopher.png'),
                            radius: 20,
                          ),
                        )),
                    Text(
                      UserService.to.getNickName,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
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
      ),
    );
  }

  void _showUserDialog() {
    SmartDialog.show(builder: (_) {
      final TextEditingController controller =
          TextEditingController(text: UserService.to.getNickName);
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
                IconButton(
                    onPressed: () {
                      // todo 点击切换头像
                    },
                    iconSize: 10,
                    icon: Container(
                      width: 128.0, // 设置外部容器的宽度
                      height: 128.0, // 设置外部容器的高度
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black, // 边框颜色
                          width: 1.0, // 边框宽度
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('assets/images/gopher.png'),
                        radius: 20,
                      ),
                    )),
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
                          contentPadding: EdgeInsets.only(left: 10, bottom: 10),
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
                        backgroundColor: Colors.blueAccent, // 背景颜色
                        foregroundColor: Colors.white, // 文字颜色
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // 圆角
                        ),
                      ),
                      onPressed: () => (),
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
}
