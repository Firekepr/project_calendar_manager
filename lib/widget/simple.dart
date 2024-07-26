import 'package:flutter/material.dart';
import 'package:project_calendar_manager/styles/colors/app_colors.dart';
import 'package:project_calendar_manager/styles/colors/app_colors_extension.dart';
import 'package:project_calendar_manager/styles/font/font_size.dart';
import 'package:project_calendar_manager/styles/text_style/text_style.dart';

class SimpleWidget {
  static Widget customText({
    required String text,
    String alternativeText = 'Add alternative text',
    bool centerText = false,
    bool hide = false,
    bool bold = false,
    bool normal = false,
    bool alert = false,
    bool noScaled = false,
    bool highLight = false,
    bool underLine = false,
    bool required = false,
    bool disable = false,
    Widget? leading,
    double distanceBetween = 10,
    EdgeInsets padding = EdgeInsets.zero,
    EdgeInsets leadingPadding = EdgeInsets.zero,
    TextStyle? style,
    Widget? customHideWidget,
    AppColors? color,
    Color? customColor,
    FontSize size = FontSize.medium,
    int? maxLines,
    TextOverflow overflow = TextOverflow.visible,
  }) {
    final body = Text(
      textScaler: noScaled ? const TextScaler.linear(1.0) : null,
      hide && alternativeText != 'Add alternative text'
          ? alternativeText
          : required
              ? '$text*'
              : text,
      textAlign: centerText ? TextAlign.center : TextAlign.start,
      maxLines: maxLines,
      overflow: overflow,
      style: style ??
          AppTextStyle.custom(
            size: size,
            bold: bold,
            color: color,
            customColor: customColor,
            normal: normal,
            alert: alert,
            disable: disable,
            highLight: highLight,
            underLine: underLine,
          ),
    );

    if (leading != null && !hide) {
      return Padding(
        padding: leadingPadding,
        child: Row(
          children: [
            leading,
            SizedBox(width: distanceBetween),
            body,
          ],
        ),
      );
    }

    if (!hide && padding != EdgeInsets.zero) {
      return Padding(
        padding: padding,
        child: body,
      );
    }

    return hide && alternativeText == 'Add alternative text'
        ? customHideWidget ?? Container()
        : body;
  }

  static Widget customContainer({
    required Widget child,
    bool hide = false,
    bool expanded = false,
    Widget? hideWidget,
    double? width,
    double? height,
    double elevation = 0.0,
    double borderRadius = 0.0,
    double borderWidth = 0.0,
    AppColors bgColor = AppColors.transparent,
    AppColors bdColor = AppColors.transparent,
    Decoration? decoration,
    EdgeInsets padding = EdgeInsets.zero,
    EdgeInsets margin = EdgeInsets.zero,
    void Function()? onTap,
    bool showSplashOnTap = false,
  }) {
    if (hide) return hideWidget ?? Container();

    Widget component = Container(
      width: width,
      height: height,
      padding: padding,
      decoration: decoration ??
          BoxDecoration(
            color: bgColor.color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: borderWidth,
              color: bdColor.color,
            ),
          ),
      child: child,
    );

    if (onTap != null) {
      component = showSplashOnTap
          ? InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(borderRadius),
              child: component,
            )
          : GestureDetector(
              onTap: onTap,
              child: component,
            );
    }

    if (elevation > 0.0 || borderRadius > 0.0) {
      component = Material(
        elevation: elevation,
        color: AppColors.whiteFade.color,
        shadowColor: AppColors.black.color,
        borderRadius: BorderRadius.circular(borderRadius),
        child: component,
      );
    }

    if (margin != EdgeInsets.zero) {
      component = Container(
        margin: margin,
        child: component,
      );
    }

    return expanded ? Expanded(child: component) : component;
  }
}
