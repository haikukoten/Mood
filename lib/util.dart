import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

/// 为了方便Vscode Color Highlight扩展高亮颜色而创建的工具函数
///
/// Create a color from red, green, blue, and opacity, similar to `rgba()` in CSS.
///
/// * `r` is [red], from 0 to 255.
/// * `g` is [green], from 0 to 255.
/// * `b` is [blue], from 0 to 255.
/// * `opacity` is alpha channel of this color as a double, with 0.0 being
///   transparent and 1.0 being fully opaque.
///
/// Out of range values are brought into range using modulo 255.
///
/// See also [fromARGB], which takes the opacity as an integer value.
Color colorRGB(int r, int g, int b, [double opacity = 1]) => Color.fromRGBO(r, g, b, opacity);

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 3,
    lineLength: 72,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

/// 用来获取[PageController]所绑定的PageView的当前page,当未绑定时将返回0
double getPage(PageController controller) {
  try {
    return controller.page;
  } catch (e) {
    return 0;
  }
}

/// 设置透明状态栏
void setTranslateStatusBar() => SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));

/// 设置全屏
void setFullScreen() => SystemChrome.setEnabledSystemUIOverlays([]);
