import 'package:flustars/flustars.dart';
import 'package:game/models/create_room.dart';
import 'package:game/service/room_service.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  Rx<String> roomNumberStr = ''.obs;

  Rx<int> playerNum = 4.obs;

  // 卧底数量
  Rx<int> undercoverNum = 1.obs;

  // 平民数量
  Rx<int> civiliansNum = 3.obs;



  joinRoom(int roomNumber) {
    print('加入房间号：$roomNumber');

    // todo 调用接口

    // 跳转到房间大厅


    // 建立ws
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
    print('创建房间 $playerNum $undercoverNum $civiliansNum');


    int roomId = await RoomService.to.createRoom(CreateRoomReq(playerNum.value, undercoverNum.value, civiliansNum.value));
    if (roomId == 0) {
      // todo 提示创建失败
      return;
    }
    SpUtil.putInt("roomId", roomId);

    // todo 跳转到房间大厅


  }
}
