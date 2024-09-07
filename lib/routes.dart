import 'package:game/page/home/view.dart';
import 'package:game/page/undercover/home/view.dart';
import 'package:game/page/undercover/room/view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';


final List<GetPage> routes = [
  GetPage(name: '/', page: () => HomePage()),
  GetPage(name: '/undercover', page: () => UndercoverHomePage()),
  GetPage(name: '/undercover/room/:roomId', page: () => RoomPage())
];
