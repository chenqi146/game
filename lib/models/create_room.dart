

import 'package:json_annotation/json_annotation.dart';


part 'create_room.g.dart';

@JsonSerializable()
class CreateRoomReq {

  CreateRoomReq(this.playerNum, this.undercoverNum, this.civilianNum);


  int playerNum;
  int undercoverNum;
  int civilianNum;

  factory CreateRoomReq.fromJson(Map<String, dynamic> json) => _$CreateRoomReqFromJson(json);
  Map<String, dynamic> toJson() => _$CreateRoomReqToJson(this);

}
