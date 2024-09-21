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
  List<int>? undercoverUserIds;
  List<int>? civilianUserIds;
  List<int>? eliminatedUserIds;

  GameInfo({
    required this.gameId,
    required this.undercoverWord,
    required this.civilianWord,
    this.undercoverUserIds,
    this.civilianUserIds,
    this.eliminatedUserIds,
  });

  factory GameInfo.fromJson(Map<String, dynamic> json) {
    return GameInfo(
      gameId: json["gameId"],
      undercoverWord: json["undercoverWord"],
      civilianWord: json["civilianWord"],
      undercoverUserIds: json["undercoverUserIds"] != null ? List<int>.from(json["undercoverUserIds"].map((x) => x)) : null,
      civilianUserIds: json["civilianUserIds"] != null ? List<int>.from(json["civilianUserIds"].map((x) => x)) : null,
      eliminatedUserIds: json["eliminatedUserIds"] != null ? List<int>.from(json["eliminatedUserIds"].map((x) => x)) : null,
    );
  }
  
  

  Map<String, dynamic> toJson() => {
        "gameId": gameId,
        "undercoverWord": undercoverWord,
        "civilianWord": civilianWord,
        "undercoverUserIds": undercoverUserIds,
        "civilianUserIds": civilianUserIds,
        "eliminatedUserIds": eliminatedUserIds
      };
}
