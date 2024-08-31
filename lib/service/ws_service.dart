import 'package:game/app_constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketService {
  int? userId;
  int? roomId;

  WebSocketChannel? channel;

  WebsocketService._internal();

  static final WebsocketService _instance = WebsocketService._internal();

  factory WebsocketService() {
    return _instance;
  }

  void connect(int userId) {
    this.userId = userId;
    channel ??= WebSocketChannel.connect(
          Uri.parse('${ApiConstants.wsBaseUrl}?userId=$userId'));

  }

  void send(String message) {
    print('send message: $message');
  }

  void close() {
    print('close ws connection');
  }
}
