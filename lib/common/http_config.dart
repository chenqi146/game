import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/adapter_browser.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';

import 'base/base_exceptions.dart';

class HttpConfig {
  final String? baseUrl;
  final String? cookiesPath;
  final List<Interceptor>? interceptors;
  final int connectTimeout;
  final int sendTimeout;
  final int receiveTimeout;
  final Map<String, dynamic>? headers;

  HttpConfig({
    this.baseUrl,
    this.headers,
    this.cookiesPath,
    this.interceptors,
    this.connectTimeout = Duration.millisecondsPerMinute,
    this.sendTimeout = Duration.millisecondsPerMinute,
    this.receiveTimeout = Duration.millisecondsPerMinute,
  });
}

// ################################ 解析 ################################

class R<T> {
  late bool ok;
  T? data;
  dynamic _json;
  HttpException? error;

  /// 以Json对象的方式获取data对象
  Map<String, dynamic>? getDataJson() {
    if (_json is Map<String, dynamic>) {
      return _json as Map<String, dynamic>;
    }
    return null;
  }


  dynamic get json => _json;

  /// 基本类型转换为指定的泛型类型
  // ignore: avoid_shadowing_type_parameters
  R<T> convert<T>({T? data}) {
    var result = R<T>.of(this.ok, this._json, this.error);
    result.data = data;
    return result;
  }

  R.of(this.ok, this._json, this.error);


  R.ok(this._json) {
    ok = true;
  }

  R.error(int? code, String? message) {
    ok = false;
    error = BadRequestException(message: message, code: code);
  }

  R.errorFormError([HttpException? error]) {
    ok = false;
    this.error = error ?? UnknownException();
  }
}

R handleResponse(Response? response, {HttpTransformer? httpTransformer}) {
  httpTransformer ??= DefaultHttpTransformer.getInstance();

  // 返回值异常
  if (response == null) {
    return R.errorFormError();
  }

  // 接口调用成功
  if (_isRequestSuccess(response.statusCode)) {
    return httpTransformer.parse(response);
  } else {
    // 接口调用失败
    return R.error(response.statusCode, response.statusMessage);
  }
}

/// 请求成功
bool _isRequestSuccess(int? statusCode) {
  return (statusCode != null && statusCode >= 200 && statusCode < 300);
}

// 调用成功后来解析数据的
abstract class HttpTransformer {
  R parse(Response response);
}

class DefaultHttpTransformer extends HttpTransformer {
  @override
  R parse(Response response) {
    // 将response.data转换为R
    if (response.statusCode == 200) {
      return _parseResponse(response);
    } else {
      return R.error(response.statusCode!, response.statusMessage!);
    }
  }

  /// 单例对象
  static final DefaultHttpTransformer _instance =
      DefaultHttpTransformer._internal();

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  DefaultHttpTransformer._internal();

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory DefaultHttpTransformer.getInstance() => _instance;
}

R _parseResponse(Response response) {
  if (response.data is Map) {
    final data = response.data;
    if (data.containsKey("code")) {
      final code = data["code"];
      if (code == 0) {
        return R.ok(data["data"]);
      } else {
        return R.errorFormError(
            BadResponseException.withMessage(data["msg"], code, data["data"]));
      }
    } else {
      return R.error(-1, "未知错误");
    }
  } else {
    return R.error(-1, "未知错误");
  }
}

R handleException(Exception exception) {
  var parseException = _parseException(exception);
  return R.errorFormError(parseException);
}

HttpException _parseException(Exception error) {
  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        return NetworkException(message: error.message);
      case DioErrorType.cancel:
        return CancelException(error.message);
      case DioErrorType.response:
        try {
          int? errCode = error.response?.statusCode;
          switch (errCode) {
            case 400:
              return BadRequestException(message: "请求语法错误", code: errCode);
            case 401:
              return UnauthorisedException(message: "没有权限", code: errCode);
            case 403:
              return BadRequestException(message: "服务器拒绝执行", code: errCode);
            case 404:
              return BadRequestException(message: "无法连接服务器", code: errCode);
            case 405:
              return BadRequestException(message: "请求方法被禁止", code: errCode);
            case 500:
              return BadServiceException(message: "服务器内部错误", code: errCode);
            case 502:
              return BadServiceException(message: "无效的请求", code: errCode);
            case 503:
              return BadServiceException(message: "服务器挂了", code: errCode);
            case 505:
              return UnauthorisedException(
                  message: "不支持HTTP协议请求", code: errCode);
            default:
              return UnknownException(error.message);
          }
        } on Exception catch (_) {
          return UnknownException(error.message);
        }

      case DioErrorType.other:
        if (error.error is SocketException) {
          return NetworkException(message: error.message);
        } else {
          return UnknownException(error.message);
        }
      default:
        return UnknownException(error.message);
    }
  } else {
    return UnknownException(error.toString());
  }
}
// ################################ 解析 ################################

// ################################ dio ################################
class AppDio with DioMixin implements Dio {
  AppDio({BaseOptions? options, HttpConfig? dioConfig}) {
    options ??= BaseOptions(
      baseUrl: dioConfig?.baseUrl ?? "",
      contentType: 'application/json',
      connectTimeout: dioConfig?.connectTimeout,
      sendTimeout: dioConfig?.sendTimeout,
      receiveTimeout: dioConfig?.receiveTimeout,
    )..headers = dioConfig?.headers;
    if (kIsWeb) {
      httpClientAdapter = BrowserHttpClientAdapter();
    }else {
      httpClientAdapter = DefaultHttpClientAdapter()..onHttpClientCreate = (client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
        return null;
      };
    }
    this.options = options;

    // DioCacheManager
    final cacheOptions = CacheOptions(
      // A default store is required for interceptor.
      store: MemCacheStore(),
      // Optional. Returns a cached response on error but for statuses 401 & 403.
      hitCacheOnErrorExcept: [401, 403],
      // Optional. Overrides any HTTP directive to delete entry past this duration.
      maxStale: const Duration(days: 7),
    );
    interceptors.add(DioCacheInterceptor(options: cacheOptions));

    if (kDebugMode) {
      interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true));
    }
    if (dioConfig?.interceptors?.isNotEmpty ?? false) {
      interceptors.addAll(dioConfig!.interceptors!);
    }
  }

}
// ################################ dio ################################
