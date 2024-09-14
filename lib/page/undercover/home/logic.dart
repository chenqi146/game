import 'package:flustars/flustars.dart';
import 'package:game/common/utils/logger.dart';
import 'package:game/models/create_room.dart';
import 'package:game/page/undercover/room/view.dart';
import 'package:game/service/room_service.dart';
import 'package:game/service/ws_service.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  
  final RoomService roomService = Get.find();
  final WebsocketService websocketService = Get.find();

  Rx<String> roomNumberStr = ''.obs;

  Rx<int> playerNum = 4.obs;

  // 卧底数量
  Rx<int> undercoverNum = 1.obs;

  // 平民数量
  Rx<int> civiliansNum = 3.obs;



  joinRoom(int roomNumber) {
    LoggerUtil.i('加入房间号：$roomNumber');

    // 调用接口
    roomService.joinRoom(roomNumber);

    // 建立ws
    websocketService.initWebsocket();

    // 跳转到房间大厅
    Get.to(RoomPage(), arguments: {"roomId": roomNumber});

  }

  void updatePlayerNum(int playerNum) {
    this.playerNum.value = playerNum;
    if (playerNum >= 6 && playerNum < 10) {
      undercoverNum.value = 2;
    } else if (playerNum >= 10) {
      undercoverNum.value = 3;
    } else {
      undercoverNum.value = 1;
    }
    civiliansNum.value = playerNum - undercoverNum.value;
  }

  void createRoom() async {
    LoggerUtil.i('创建房间 $playerNum $undercoverNum $civiliansNum');


    int roomId = await RoomService.to.createRoom(CreateRoomReq(playerNum.value, undercoverNum.value, civiliansNum.value));
    SpUtil.putInt("roomId", roomId);

    // todo 跳转到房间大厅


  }
}
