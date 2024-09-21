import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class BaseDialog {
  // 显示普通提示
  static void showToast(
    String message, {
    Duration duration = const Duration(seconds: 2),
    Alignment alignment = Alignment.center,
  }) {
    SmartDialog.showToast(
      message,
      displayTime: duration,
      alignment: alignment,
    );
  }

  // 显示加载中对话框
  static void showLoading({
    String? msg,
    bool clickMaskDismiss = false,
    Widget? custom,
  }) {
    SmartDialog.showLoading(
      msg: msg ?? '',
      clickMaskDismiss: clickMaskDismiss,
      builder: custom != null ? (_) => custom : null,
    );
  }

  // 隐藏加载中对话框
  static void dismissLoading() {
    SmartDialog.dismiss();
  }

  // 显示自定义对话框
  static Future<T?> showCustomDialog<T>({
    required Widget child,
    bool clickMaskDismiss = true,
    Duration? animationTime,
    Alignment alignment = Alignment.center,
  }) {
    return SmartDialog.show<T>(
      builder: (_) => child,
      clickMaskDismiss: clickMaskDismiss,
      animationTime: animationTime,
      alignment: alignment,
    );
  }

  // 显示确认对话框
  static Future<bool?> showConfirmDialog({
    required String title,
    required String content,
    String cancelText = '取消',
    String confirmText = '确认',
    Color? confirmColor,
  }) {
    return SmartDialog.show<bool>(
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => SmartDialog.dismiss(result: false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => SmartDialog.dismiss(result: true),
            child: Text(
              confirmText,
              style: TextStyle(color: confirmColor),
            ),
          ),
        ],
      ),
    );
  }

  // 显示底部弹出菜单
  static Future<T?> showBottomSheet<T>({
    required Widget child,
    bool clickMaskDismiss = true,
    double? height,
  }) {
    return SmartDialog.show<T>(
      builder: (_) => child,
      clickMaskDismiss: clickMaskDismiss,
      alignment: Alignment.bottomCenter,
      animationType: SmartAnimationType.centerScale_otherSlide,
      usePenetrate: true,
      useAnimation: true,
      onDismiss: () {},
      maskColor: Colors.black.withOpacity(0.5),
      debounce: true,
    );
  }

  // 显示自定义通知
  static void showNotification({
    required Widget child,
    Duration displayTime = const Duration(seconds: 4),
    Alignment alignment = Alignment.topCenter,
    required NotifyType notifyType,
  }) {
    SmartDialog.showNotify(
      msg: '',
      builder: (_) => child,
      displayTime: displayTime,
      alignment: alignment,
      notifyType: notifyType
    );
  }

  // 显示输入对话框
  static Future<String?> showInputDialog({
    required String title,
    String? hintText,
    String cancelText = '取消',
    String confirmText = '确认',
  }) {
    final TextEditingController controller = TextEditingController();
    return SmartDialog.show<String>(
      builder: (_) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText),
        ),
        actions: [
          TextButton(
            onPressed: () => SmartDialog.dismiss(),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => SmartDialog.dismiss(result: controller.text),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}
