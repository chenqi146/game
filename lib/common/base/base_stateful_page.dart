import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'empty_controller.dart';
import 'global_key_factory.dart';


/*
 * 页面的基类，StatefulWidget 类型
 * 只用于路由中定义的页面，如果是自定义布局或者PageView的子页面则无需继承
 * 如果没有传Key,则自动管理Key
 */
abstract class BaseStatefulPage<C extends GetxController> extends StatefulWidget {
  BaseStatefulPage({Key? key}) : super(key: key ?? GlobalKeyFactory.createGlobalKey()) {
    _createLogic();
  }

  C? _logic;

  C get controller => _logic ?? EmptyLogic() as C ;

  void _createLogic() {
    try {
      _logic = GetInstance().put<C>(createRawLogic(), tag: key?.toString());
    } catch (e) {
      _logic = null;
    }
  }

  C createRawLogic();
}
