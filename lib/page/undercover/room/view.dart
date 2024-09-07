import 'package:flutter/material.dart';
import 'package:game/common/base/base_stateful_page.dart';

import 'logic.dart';

class RoomPage extends BaseStatefulPage<RoomLogic> {
  RoomPage({Key? key}) : super(key: key);


  @override
  RoomLogic createRawLogic() {
    return RoomLogic();
  }

  @override
  State<StatefulWidget> createState() => _RoomPage();
}

class _RoomPage extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('房间'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
