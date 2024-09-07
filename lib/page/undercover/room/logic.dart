import 'package:flustars/flustars.dart';
import 'package:game/api/room_repository.dart';
import 'package:game/models/game_info.dart';
import 'package:game/models/room.dart';
import 'package:game/service/room_service.dart';
import 'package:game/service/user_service.dart';
import 'package:get/get.dart';

class RoomLogic extends GetxController {

  final RoomService roomService = Get.find();

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

  bool isRoomOwner() {
    return room.value.homeOwnersUserId == UserService.to.getUserId;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    // 建立房间后初始化数据, 通过路由传递的参数
    int roomId = Get.parameters['roomId'] as int;
    // 调用接口初始化数据
    room.value = await roomService.getRoom(roomId);


  }

}
