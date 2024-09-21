// To parse this JSON data, do
//
//     final room = roomFromJson(jsonString);

import 'dart:convert';

import 'package:game/models/game_info.dart';
import 'package:game/models/user.dart';

Room roomFromJson(String str) => Room.fromJson(json.decode(str));

String roomToJson(Room data) => json.encode(data.toJson());

class Room {
  int roomId;
  int playerNum;
  int undercoverNum;
  int civilianNum;
  int homeOwnersUserId;
  int status;
  List<User> users;
  GameInfo? game;

  Room({
    required this.roomId,
    required this.playerNum,
    required this.undercoverNum,
    required this.civilianNum,
    required this.homeOwnersUserId,
    required this.status,
    required this.users,
    this.game,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    if (json["game"] != null) {
      return Room(
        roomId: json["roomId"],
        playerNum: json["playerNum"],
        undercoverNum: json["undercoverNum"],
        civilianNum: json["civilianNum"],
        homeOwnersUserId: json["homeOwnersUserId"],
        status: json["status"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        game: GameInfo.fromJson(json["game"]),
      );
    } else {
      return Room(
        roomId: json["roomId"],
        playerNum: json["playerNum"],
        undercoverNum: json["undercoverNum"],
        civilianNum: json["civilianNum"],
        homeOwnersUserId: json["homeOwnersUserId"],
        status: json["status"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "roomId": roomId,
        "playerNum": playerNum,
        "undercoverNum": undercoverNum,
        "civilianNum": civilianNum,
        "homeOwnersUserId": homeOwnersUserId,
        "status": status,
        "users": List<User>.from(users.map((x) => x.toJson())),
        "game": game?.toJson(),
      };
}
