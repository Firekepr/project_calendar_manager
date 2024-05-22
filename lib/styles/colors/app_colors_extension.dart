import 'package:flutter/material.dart';
import 'package:project_calendar_manager/styles/colors/app_colors.dart';

extension AppGetColors on AppColors {
  Color get color {
    switch (this) {
      case AppColors.red:
        return Colors.red;

      case AppColors.black:
        return Colors.black;

      case AppColors.white:
        return Colors.white;

      default:
        return Colors.white;
    }
  }
}