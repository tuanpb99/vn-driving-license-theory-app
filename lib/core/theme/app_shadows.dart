import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Color(0x4D000000),
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
  ];

  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Color(0x66000000),
      offset: Offset(0, 4),
      blurRadius: 12,
    ),
  ];

  static const List<BoxShadow> shadowLg = [
    BoxShadow(
      color: Color(0x80000000),
      offset: Offset(0, 8),
      blurRadius: 24,
    ),
  ];

  static const List<BoxShadow> shadowGlowBlue = [
    BoxShadow(
      color: Color(0x4D4A9FD8),
      offset: Offset(0, 0),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadowGlowGreen = [
    BoxShadow(
      color: Color(0x4D30D158),
      offset: Offset(0, 0),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];
}
