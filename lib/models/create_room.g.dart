// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRoomReq _$CreateRoomReqFromJson(Map<String, dynamic> json) =>
    CreateRoomReq(
      (json['playerNum'] as num).toInt(),
      (json['undercoverNum'] as num).toInt(),
      (json['civilianNum'] as num).toInt(),
    );

Map<String, dynamic> _$CreateRoomReqToJson(CreateRoomReq instance) =>
    <String, dynamic>{
      'playerNum': instance.playerNum,
      'undercoverNum': instance.undercoverNum,
      'civilianNum': instance.civilianNum,
    };
