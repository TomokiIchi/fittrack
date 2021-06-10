//Todo lib/utisl.dart  の utisl  って何の略でしょうか？
import 'package:flutter/material.dart';

class AppColor {
  static const mainBgColor = Color(0xFFfDfDfD);
  static const darkColor = Color(0xFFFC6076);
  static const midColor = Color(0xFFFE8060);
  static const lightColor = Color(0xFFFF9A44);
  static const darkRedColor = Color(0xFFFA695C);
  static const lightRedColor = Color(0xFFFD685A);
  static const textcolor = Colors.black;
  static const errorcolor = Colors.red;

  static const purpleGradient = LinearGradient(
    colors: <Color>[darkColor, midColor, lightColor],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const redGradient = LinearGradient(
    colors: <Color>[darkRedColor, lightRedColor],
    stops: [0.0, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
