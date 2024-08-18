import 'package:flutter/material.dart';

/*
 * 全局的Key管理，可以用于默认页面或Widgert标识
 */
class GlobalKeyFactory {
  static BigInt _counter = BigInt.zero;

  static GlobalKey createGlobalKey() {
    final key = GlobalKey(debugLabel: 'global_key_${_counter.toString()}');
    _counter += BigInt.one;
    return key;
  }
}
