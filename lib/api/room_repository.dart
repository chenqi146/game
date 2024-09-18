

import 'package:game/common/http_client.dart';
import 'package:game/common/http_config.dart';
import 'package:game/models/create_room.dart';
import 'package:game/models/game_info.dart';
import 'package:game/models/room.dart';
import 'package:get/get.dart';

class RoomRepository extends GetxService {
  final HttpClient httpClient;

  RoomRepository({required this.httpClient});


  Future<R<int>> createRoom(CreateRoomReq req) async {

    final res = await httpClient.post("/room/create", data: req.toJson());
    if (res.ok) {
      return res.convert(data: res.getDataJson()?["roomId"]);
    }
    return res.convert();
  }

  Future<R<Room>> getRoom(int roomId) async {

    final res = await httpClient.post("/room/info", data: {"roomId": roomId});
    if (res.ok) {
      return res.convert(data: Room.fromJson(res.getDataJson()!));
    }
    return res.convert();
  }

  Future<R<void>> joinRoom(int roomId) async {
    final res = await httpClient.post("/room/join", data: {"roomId": roomId});
    return res.convert();
  }

  Future<R<GameInfo>> startGame(int roomId) async {
    final res = await httpClient.post("/room/startGame", data: {"roomId": roomId});
    if (res.ok) {
      return res.convert(data: GameInfo.fromJson(res.getDataJson()!));
    }
    return res.convert();
  }

  Future<R<void>> eliminateUser(int roomId, int userId) async {
    final res = await httpClient.post("/room/eliminateUser", data: {"roomId": roomId, "userId": userId});
    return res.convert();
  }

  Future<R<void>> changeWord(int roomId) async {
    final res = await httpClient.post("/room/changeWord", data: {"roomId": roomId});
    return res.convert();
  }

  Future<R<void>> gameOver(int roomId) async {
    final res = await httpClient.post("/room/gameOver", data: {"roomId": roomId});
    return res.convert();
  }

}