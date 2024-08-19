

import 'package:game/common/http_client.dart';
import 'package:game/common/http_config.dart';
import 'package:game/models/create_room.dart';
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

}