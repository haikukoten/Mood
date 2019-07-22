import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTheme with ChangeNotifier {
  static final List<List<Color>> colorList = [
    <Color>[
      Color(0xFF3C8CE7),
      Color(0xFF00EAFF),
    ],
    <Color>[
      Color(0xFFE2B0FF),
      Color(0xFF9F44D3),
    ],
    <Color>[
      Color(0xFFABDCFF),
      Color(0xFF0396FF),
    ],
    <Color>[
      Color(0xFFFEB692),
      Color(0xFFEA5455),
    ],
    <Color>[
      Color(0xFF90F7EC),
      Color(0xFF32CCBC),
    ],
    <Color>[
      Color(0xFFFFF720),
      Color(0xFF3CD500),
    ],
  ];

  var _colorIndex = 0;

  get colorIndex => _colorIndex;

  set colorIndex(colorIndex) {
    _colorIndex = colorIndex;
    notifyListeners();
  }

  Color get accentColor => currentColors[1];

  List<Color> get currentColors => colorList[colorIndex];
}
