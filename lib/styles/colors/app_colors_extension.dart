import 'package:flutter/material.dart';
import 'package:project_calendar_manager/service/context/ContextService.dart';
import 'package:project_calendar_manager/service/utils/utils.dart';
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

      case AppColors.whiteFade:
        return UtilsS.fromHex('#FAFAFA');

      case AppColors.grey:
        return Colors.grey;

      case AppColors.transparent:
        return Colors.transparent;

      case AppColors.yellow:
        return Colors.yellow;

      case AppColors.yellowDark:
        return Colors.yellow.shade600;

      case AppColors.graphite:
        return const Color.fromRGBO(51, 51, 51, 0.8);

      case AppColors.primary:
        return Theme.of(ContextService.context).primaryColor;

      case AppColors.secondary:
        return Theme.of(ContextService.context).secondaryHeaderColor;

      default:
        return Colors.white;
    }
  }
}