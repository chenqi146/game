import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:game/app_binding.dart';
import 'package:game/common/http_interceptor.dart';
import 'package:get/get.dart';

import 'app_constants.dart';
import 'common/http_client.dart';
import 'common/http_config.dart';
import 'routes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  //初始化SP
  await SpUtil.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Game App',
      enableLog: true,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: '/',
      initialBinding: AppBinding(),
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      // routes: routes
    );
  }
}
