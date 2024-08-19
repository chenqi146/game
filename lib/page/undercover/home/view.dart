import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:game/common/base/base_stateful_page.dart';
import 'package:get/get.dart';

import 'logic.dart';

class UndercoverHomePage extends BaseStatefulPage<HomeLogic> {
  UndercoverHomePage({Key? key}) : super(key: key);

  @override
  HomeLogic createRawLogic() {
    return HomeLogic();
  }

  @override
  State<StatefulWidget> createState() => _UndercoverHomePage();
}

class _UndercoverHomePage extends State<UndercoverHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('谁是卧底'),
      ),
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.amber,
              child: const Text('创建房间'),
              onPressed: () {
                showCreateRoomDialog();
              },
            ),
            const SizedBox(height: 16),
            MaterialButton(
              color: Colors.blue,
              child: const Text('加入房间'),
              onPressed: () {
                showJoinRoomDialog();
              },
            )
          ],
        ),
      ),
    );
  }

  void showCreateRoomDialog() async {
    SmartDialog.show(
      usePenetrate: false,
      keepSingle: true,
      builder: (context) {
        return Container(
          width: 300,
          height: 320,
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
                const Text(
                  '创建房间',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('玩家数量:'),
                    const SizedBox(width: 10),
                    Container(
                        width: 180,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(() => Slider(
                              value: widget.logic.playerNum.value.toDouble(),
                              min: 3,
                              max: 12,
                              onChanged: (value) {
                                widget.logic.updatePlayerNum(value.toInt());
                              },
                            ))),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        const Text('玩家数量'),
                        Obx(() => Text('${widget.logic.playerNum.value}')),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        const Text('卧底数量'),
                        Obx(() => Text('${widget.logic.undercoverNum.value}')),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        const Text('平民数量'),
                        Obx(() => Text('${widget.logic.civiliansNum.value}')),
                      ],
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
                      onPressed: () {
                        widget.logic.createRoom();
                      },
                      child: const Text('确认'),
                    ),
                  ],
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        );
      },
    );
  }

  void showJoinRoomDialog() async {
    SmartDialog.show(
      usePenetrate: false,
      keepSingle: true,
      builder: (context) {
        return Container(
          width: 300,
          height: 250,
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
                const Text(
                  '请输入房间号',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Text('昵称:'),
                    // const SizedBox(width: 10),
                    Container(
                      width: 180,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        // 默认值
                        controller: TextEditingController(
                            text: widget.logic.roomNumberStr.value),
                        onChanged: (value) {
                          widget.logic.roomNumberStr.value = value;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                        keyboardType: TextInputType.number,
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
                      onPressed: () => (widget.logic.joinRoom(
                          int.parse(widget.logic.roomNumberStr.value))),
                      child: const Text('确认'),
                    ),
                  ],
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        );
      },
    );
  }
}
