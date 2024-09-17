import 'package:event_bus/event_bus.dart';

class EventBusUtil {
  static EventBusUtil get instance => _instance;
  static final EventBusUtil _instance = EventBusUtil._internal();
  static late EventBus eventBus;

  EventBusUtil._internal() {
    // 初始化
    eventBus = EventBus();
  }

  factory EventBusUtil() => _instance;


  void fire(event) {
    eventBus.fire(event);
  }


}
