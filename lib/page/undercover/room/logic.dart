import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:game/api/room_repository.dart';
import 'package:game/common/utils/logger.dart';
import 'package:game/models/game_info.dart';
import 'package:game/models/room.dart';
import 'package:game/service/room_service.dart';
import 'package:game/service/user_service.dart';
import 'package:game/service/ws_service.dart';
import 'package:get/get.dart';

class RoomLogic extends GetxController {
  final RoomService roomService = Get.find();
  final WebsocketService websocketService = Get.find();

  var room = Room(
    roomId: 0,
    playerNum: 0,
    undercoverNum: 0,
    civilianNum: 0,
    homeOwnersUserId: 0,
    status: 0,
    users: [],
    game: GameInfo(
      gameId: 0,
      undercoverWord: '',
      civilianWord: '',
      undercoverUserIds: [],
      civilianUserIds: [],
      eliminatedUserIds: [],
    ),
  ).obs;

  int get roomId => room.value.roomId;

  bool isRoomOwner() {
    return room.value.homeOwnersUserId == UserService.to.getUserId;
  }

  String getHomeOwnerName() {
    final homeOwner = room.value.users.firstWhere((user) => user.userId == room.value.homeOwnersUserId);
    return homeOwner.nickname;
  }

  initData() async {
    try {
      // 建立房间后初始化数据, 通过路由传递的参数
      final Map<String, dynamic> args = Get.arguments;
      LoggerUtil.i('房间大厅: 路由参数 => $args');
      int roomId = args['roomId'] as int;
      // 调用接口初始化数据
      room.value = await roomService.getRoom(roomId);
      // 建立ws
      websocketService.initWebsocket();
    } catch (e, stackTrace) {
      LoggerUtil.e('房间大厅异常, ${e.toString()}\n堆栈信息: $stackTrace');
    }
  }
}
