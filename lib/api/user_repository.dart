
import 'package:game/common/http_client.dart';
import 'package:game/common/http_config.dart';
import 'package:get/get.dart';

class UserRepository extends GetxService {
  final HttpClient httpClient;

  UserRepository({required this.httpClient});

  Future<R<int>> createUser(String nickname, String? avatar) async {
    final res = await httpClient
        .post("/user/create", data: {"nickname": nickname, "avatar": avatar});
    if (res.ok) {
      return res.convert(data: res.getDataJson()!["userId"]);
    }
    return res.convert();
  }

  Future<R<void>> updateUser(int id, String nickname, String? avatar) async {
    final res = await httpClient.post("/user/update",
        data: {"id": id, "nickname": nickname, "avatar": avatar});
    return res;
  }
}
