import 'package:flutter/material.dart';
import 'package:game/page/home/view.dart';
import 'package:game/page/undercover/home.dart';
import 'package:game/page/undercover/room.dart';


final Map<String,Function> routes = {
  '/': (context) => HomePage(),
  '/undercover': (context) => const UndercoverHomePage(),
  '/undercover/createRoom': (context) => const RoomCreatePage()
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
