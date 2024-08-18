import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'empty_controller.dart';
import 'global_key_factory.dart';

/*
 * 页面的基类，StatelessWidget 类型
 * 只用于路由中定义的页面，如果是自定义布局或者PageView的子页面则无需继承
 * 如果没有传Key,则自动管理Key
 */
abstract class BaseStatelessPage<C extends GetxController> extends StatelessWidget {
  BaseStatelessPage({Key? key}) : super(key: key ?? GlobalKeyFactory.createGlobalKey()) {
    _createController();
  }

  bool _initStatePerformed = false;

  C? _controller;

  C get controller => _controller ?? EmptyLogic() as C;

  void _createController() {
    try {
      _controller = GetInstance().put<C>(createRawController(), tag: key?.toString());
    } catch (e) {
      _controller = null;
    }
  }

  C createRawController();

  @protected
  Widget buildWidget(BuildContext context);

  void initState();

  @override
  Widget build(BuildContext context) {
    if (!_initStatePerformed) {
      initState();
      _initStatePerformed = true;
    }
    return buildWidget(context);
  }

  //创建自动绑定Controller的GetBuilder
  GetBuilder<C> autoCtlGetBuilder({
    required Widget Function(C controller) builder,
    final Object? id, //Controller根据id来刷新指定的GetBuilder区域
    final bool autoRemove = true,
    final bool global = true,
    final bool assignId = false,
    final void Function(GetBuilderState<C> state)? initState,
    final void Function(GetBuilderState<C> state)? dispose,
    final void Function(GetBuilderState<C> state)? didChangeDependencies,
  }) {
    assert(_controller != null, "controller不能为空，请在 BaseState 与 BaseStatefulPage 中指定正确的泛型自动初始化");

    return GetBuilder<C>(
      init: _controller,
      tag: key?.toString(),
      builder: builder,
    );
  }
}
