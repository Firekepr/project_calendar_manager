import 'package:flutter/material.dart';
import 'package:project_calendar_manager/styles/colors/app_colors.dart';
import 'package:project_calendar_manager/styles/colors/app_colors_extension.dart';
import 'package:project_calendar_manager/styles/font/font_size.dart';
import 'package:project_calendar_manager/styles/font/font_size_extension.dart';

class AppTextStyle {

  static TextStyle custom({
    required FontSize size,
    bool bold = false,
    AppColors? color,
    Color? customColor,
    bool alert = false,
    bool normal = false,
    bool highLight = false,
    bool underLine = false,
    bool disable = false,
    double? height,
  }) {
    return TextStyle(
      fontSize: size.size,
      fontWeight: bold ? FontWeight.bold: FontWeight.normal,
      decoration: underLine ? TextDecoration.underline : null,
      height: height,
      color: _getColor(disable, highLight, color, alert, normal, customColor),
    );
  }

  static Color _getColor(bool disable, bool highLight, AppColors? color, bool alert, bool normal, Color? customColor) {
    if (disable) return AppColors.grey.color;
    if (highLight) return AppColors.white.color;
    if (color != null) return color.color;
    if (alert) return AppColors.red.color;
    if (normal) return AppColors.black.color;
    return customColor ?? AppColors.graphite.color;
  }

}