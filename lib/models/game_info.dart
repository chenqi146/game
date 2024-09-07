// To parse this JSON data, do
//
//     final gameInfo = gameInfoFromJson(jsonString);

import 'dart:convert';

GameInfo gameInfoFromJson(String str) => GameInfo.fromJson(json.decode(str));

String gameInfoToJson(GameInfo data) => json.encode(data.toJson());

class GameInfo {
  int gameId;
  String undercoverWord;
  String civilianWord;
  List<int> undercoverUserIds;
  List<int> civilianUserIds;
  List<int> eliminatedUserIds;

  GameInfo({
    required this.gameId,
    required this.undercoverWord,
    required this.civilianWord,
    required this.undercoverUserIds,
    required this.civilianUserIds,
    required this.eliminatedUserIds,
  });

  factory GameInfo.fromJson(Map<String, dynamic> json) => GameInfo(
    gameId: json["gameId"],
    undercoverWord: json["undercoverWord"],
    civilianWord: json["civilianWord"],
    undercoverUserIds: List<int>.from(json["undercoverUserIds"].map((x) => x)),
    civilianUserIds: List<int>.from(json["civilianUserIds"].map((x) => x)),
    eliminatedUserIds: List<int>.from(json["eliminatedUserIds"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "gameId": gameId,
    "undercoverWord": undercoverWord,
    "civilianWord": civilianWord,
    "undercoverUserIds": List<dynamic>.from(undercoverUserIds.map((x) => x)),
    "civilianUserIds": List<dynamic>.from(civilianUserIds.map((x) => x)),
    "eliminatedUserIds": List<dynamic>.from(eliminatedUserIds.map((x) => x)),
  };
}
