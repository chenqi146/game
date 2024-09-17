

class WsMessage<T> {
  WsMessageType type;
  T data;

  WsMessage({
    required this.type,
    required this.data,
  });

  factory WsMessage.fromJson(Map<String, dynamic> json) => WsMessage(
    type: json["type"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": data,
  };

  @override
  String toString() {
    return 'WsMessage{type: $type, data: $data}';
  }

}

enum WsMessageType {
  // 进入房间
  enterRoom,
  // 离开房间
  leaveRoom,
  // 开始游戏
  startGame,
  // 结束游戏
  endGame,
  // 游戏信息
  gameInfo,
  // 游戏消息
  gameMessage,
  // 游戏结果
  gameResult,
  // 用户信息
  userInfo,
  // 心跳
  ping,
  // 心跳回应
  pong,
}