import 'package:flutter/material.dart';
import '../main.dart';
import 'constant.dart';

double get screenHeight =>
    MediaQuery.of(navigatorKey.currentContext!).size.height;
double get screenWidth =>
    MediaQuery.of(navigatorKey.currentContext!).size.width;

double widgetHeight(double pixels) {
  return MediaQuery.of(navigatorKey.currentContext!).size.height /
      (AppConstant.designHeight / pixels);
}

double widgetWidth(double pixels) {
  return MediaQuery.of(navigatorKey.currentContext!).size.width /
      (AppConstant.designWidth / pixels);
}
