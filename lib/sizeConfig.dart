import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? blockH; //blockSizeHorizontal
  static double? blockW; //blockSizeVerticle
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockW = screenWidth / 100;
    blockH = screenHeight / 100;
    orientation = _mediaQueryData.orientation;
  }
}
