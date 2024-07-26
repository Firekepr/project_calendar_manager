import 'package:flutter/material.dart';
import 'package:project_calendar_manager/styles/colors/app_colors.dart';
import 'package:project_calendar_manager/styles/colors/app_colors_extension.dart';
import 'package:project_calendar_manager/widget/simple.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SimpleTextButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final AppColors labelColor;
  final bool disabled;
  final bool expanded;
  final bool hidden;
  final bool centered;
  final bool loading;
  final TextStyle? labelStyle;
  final bool isFormButton;
  final bool whiteLoading;
  final bool widthByPercent;
  final FontWeight? fontWeight;
  final double loadingSize;
  final double? fontSize;
  final double height;
  final double width;
  final double? borderWidth;
  final double? radius;
  final double elevation;
  final EdgeInsetsGeometry? labelPadding;
  final EdgeInsetsGeometry margin;
  final Widget? customHiddenWidget;
  final AppColors? bgColor;
  final AppColors? bdColor;

  const SimpleTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.labelColor = AppColors.white,
    this.disabled = false,
    this.labelStyle,
    this.isFormButton = false,
    this.expanded = false,
    this.centered = false,
    this.hidden = false,
    this.loading = false,
    this.whiteLoading = true,
    this.widthByPercent = true,
    this.loadingSize = 0.7,
    this.fontWeight,
    this.fontSize,
    this.height = 30,
    this.width = double.infinity,
    this.borderWidth,
    this.labelPadding,
    this.margin = EdgeInsets.zero,
    this.radius,
    this.elevation = 2,
    this.customHiddenWidget,
    this.bgColor,
    this.bdColor,
  });

  @override
  Widget build(BuildContext context) {
    return hidden
        ? customHiddenWidget ?? Container()
        : expanded
        ? Expanded(child: body(context))
        : centered
        ? Center(child: body(context))
        : body(context);
  }

  Widget body(BuildContext context) {
    final disabled = _isDisabled(context);

    final button = Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: InkWell(
        onTap: disabled || loading ? null : onPressed,
        child: SimpleWidget.customContainer(
          elevation: elevation,
          width: widthByPercent ? MediaQuery.sizeOf(context).width * width : width,
          height: height,
          borderRadius: radius ?? 5,
          bgColor: _getBackGroundColor(),
          bdColor: _getBorderColor(),
          child: loading
              ? const LinearProgressIndicator()
              : Padding(
                  padding: labelPadding ?? const EdgeInsets.all(3.0),
                  child: Text(
                    label,
                    textScaler: const TextScaler.linear(1.0),
                    textAlign: TextAlign.center,
                    style: labelStyle ??
                        TextStyle(
                          color: labelColor.color,
                          fontSize: fontSize ?? 16,
                          fontWeight: fontWeight ?? FontWeight.normal,
                        ),
                  ),
                ),
        ),
      ),
    );

    return margin != EdgeInsets.zero
        ? Container(margin: margin, child: button)
        : button;
  }

  bool _isDisabled(BuildContext context) {
    if (isFormButton == true) {
      final form = ReactiveForm.of(context)!;

      if (form.invalid) return true;
      if (form.valid && !disabled) return false;
    }

    return disabled;
  }

  AppColors _getBackGroundColor() {
    if (bgColor != null) return bgColor!;
    return AppColors.primary;
  }

  AppColors _getBorderColor() {
    if (bdColor != null) return bdColor!;
    return AppColors.secondary;
  }
}
