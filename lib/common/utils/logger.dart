import 'package:logger/logger.dart';

class LoggerUtil {
  LoggerUtil._internal() {
    Logger.level = Level.verbose;
    initLogger();
  }

  static final LoggerUtil _instance = LoggerUtil._internal();

  static Future<LoggerUtil> getInstance() async {
    return _instance;
  }

  late Logger _logger;

  Future<void> initLogger() async {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
    );
  }

  static void v(dynamic message) {
    _instance._logger.v(message);
  }

  static void d(dynamic message) {
    _instance._logger.d(message);
  }

  static void i(dynamic message) {
    _instance._logger.i(message);
  }

  static void w(dynamic message) {
    _instance._logger.w(message);
  }

  static void e(dynamic message) {
    _instance._logger.e(message);
  }

  static void wtf(dynamic message) {
    _instance._logger.wtf(message);
  }
}
