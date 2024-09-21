import 'dart:async';
import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:game/app_constants.dart';
import 'package:game/common/utils/event_bus.dart';
import 'package:game/common/utils/logger.dart';
import 'package:game/models/websocket_message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketService {
  WebsocketService._internal();

  int? userId;
  int? roomId;

  WebSocketChannel? channel;
  final int _heartTimes = 3000; // 心跳间隔(毫秒)
  final int _reconnectCount = 60; // 重连次数，默认60次
  int _reconnectTimes = 0; // 重连计数器
  Timer? _reconnectTimer; // 重连定时器

  late Timer _heartbeatTimer;
  Function? onError; // 连接错误回调
  Function? onOpen; // 连接开启回调

  static final WebsocketService _instance = WebsocketService._internal();

  factory WebsocketService() {
    return _instance;
  }

  void initWebsocket() async {
    userId = SpUtil.getInt("userId");
    channel = WebSocketChannel.connect(
        Uri.parse('${ApiConstants.wsBaseUrl}?userId=$userId'));
    // 连接成功，重置重连计数器
    _reconnectTimes = 0;
    if (_reconnectTimer != null) {
      _reconnectTimer?.cancel();
      _reconnectTimer = null;
    }
    channel?.stream.listen(webSocketOnData, onError: webSocketOnError, onDone: webSocketOnDone);
    startHeartbeat();
  }

  void webSocketOnData(event) {
    if (event == null) {
      return;
    }

    try {

      // 判断event是否是json字符串
      if (!event.startsWith('{')) {
        return;
      }

      LoggerUtil.i('onData: $event');
      var message = WsMessage.fromJson(jsonDecode(event));
      // todo 测试浏览器是否自动回复心跳
      EventBusUtil.instance.fire(message);
    } catch (e) {
      LoggerUtil.e('onData => receive data: $event, error: $e');
    }
  }

  void webSocketOnError(err) {
    LoggerUtil.e("ws连接失败: $err");
    if (channel != null) {
      channel?.sink.close();
      channel = null;
    }
    if (onError != null) {
      WebSocketChannelException ex = err;
      onError!(ex);
    }
  }


  void webSocketOnDone() {
    reconnect();
  }

  // 重连
  void reconnect() {
    LoggerUtil.i("reconnect");
    if (_reconnectTimes < _reconnectCount) {
      _reconnectTimes++;
      _reconnectTimer =
          Timer.periodic(Duration(milliseconds: _heartTimes), (timer) {
        initWebsocket();
      });
    } else {
      LoggerUtil.w('重连次数超过最大次数');
      _reconnectTimer?.cancel();
      _reconnectTimer = null;
    }
  }

  void startHeartbeat() {
    const Duration duration = Duration(seconds: 10);
    callback(timer) {
      // todo 心跳消息
      channel?.sink.add('ping');
    }

    _heartbeatTimer = Timer.periodic(duration, callback);
  }

  void close() {
    _heartbeatTimer.cancel();
    channel?.sink.close();
  }
}
