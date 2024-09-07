import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:game/app_binding.dart';
import 'package:game/common/utils/logger.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'routes.dart';

var log = Logger();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  await LoggerUtil.getInstance();

  FlutterError.onError = (details) async {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    }
  };

  runZonedGuarded(() => {runApp(const MyApp())}, (error, stack) async {
    LoggerUtil.e(error);
    LoggerUtil.e(stack);
  });
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
      initialRoute: '/',
      getPages: routes,
      initialBinding: AppBinding(),
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      // routes: routes
    );
  }
}
