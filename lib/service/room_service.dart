import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:game/api/room_repository.dart';
import 'package:game/common/base/base_exceptions.dart';
import 'package:game/common/http_config.dart';
import 'package:game/common/utils/logger.dart';
import 'package:game/models/create_room.dart';
import 'package:game/service/ws_service.dart';
import 'package:get/get.dart';

import '../models/room.dart';

class RoomService extends GetxService {
  final RoomRepository repository;
  final WebsocketService wsService;


  RoomService({required this.repository, required this.wsService});

  static RoomService get to => Get.find();

  Future<void> joinRoom(int roomId) async {
    LoggerUtil.i('join room $roomId');
    SmartDialog.showLoading();
    R<void> r = await repository.joinRoom(roomId);
    SmartDialog.dismiss(status: SmartStatus.loading);
    if (!r.ok) {
      throw BizException(r.error?.message ?? '加入房间失败');
    }
  }

  Future<int> createRoom(CreateRoomReq req) async {
    LoggerUtil.i('create room $req');

    SmartDialog.showLoading();
    R<int> r = await repository.createRoom(req);
    SmartDialog.dismiss(status: SmartStatus.loading);
    if (!r.ok) {
      throw BizException(r.error?.message ?? '创建房间失败');
    }
    return r.data!;
  }

  Future<Room> getRoom(int roomId) async {
    LoggerUtil.i('get room $roomId');
    SmartDialog.showLoading();
    R<Room> r = await repository.getRoom(roomId);
    SmartDialog.dismiss(status: SmartStatus.loading);
    if (!r.ok) {
      throw BizException(r.error?.message ?? '获取房间信息失败');
    }
    return r.data!;
  }
}
