import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:game/api/room_repository.dart';
import 'package:game/common/http_config.dart';
import 'package:game/models/create_room.dart';
import 'package:get/get.dart';

class RoomService extends GetxService {
  final RoomRepository repository;

  RoomService({required this.repository});

  static RoomService get to => Get.find();

  Future<void> joinRoom(String roomId) async {
    print('join room $roomId');
  }

  Future<int> createRoom(CreateRoomReq req) async {
    print('create room $req');

    R<int> r = await repository.createRoom(req);
    SmartDialog.dismiss(status: SmartStatus.loading);
    if (r.ok) {
      return r.data!;
    }

    return 0;
  }
}
