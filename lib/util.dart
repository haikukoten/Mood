import 'package:flutter/material.dart';

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
