import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_calendar_manager/styles/colors/app_colors.dart';
import 'package:project_calendar_manager/styles/colors/app_colors_extension.dart';
import 'package:project_calendar_manager/styles/font/font_size.dart';
import 'package:project_calendar_manager/styles/strings/app_strings.dart';
import 'package:project_calendar_manager/styles/text_style/text_style.dart';
import 'package:project_calendar_manager/widget/simple.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SimpleTextField extends StatefulWidget {
  final String label;
  final String formControlName;
  final String counterText;
  final String hint;
  final bool obscureText;
  final bool autofocus;
  final bool insideLabel;
  final bool readOnly;
  final bool required;
  final bool hidden;
  final TextInputType keyBoardType;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? suffixIcon;
  final Color suffixColor;
  final Color labelColor;
  final double elevation;
  final double? borderRadius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final int? maxLength;

  const SimpleTextField({
    super.key,
    this.label            = '',
    required this.formControlName,
    this.counterText      = '',
    this.hint             = '',
    this.obscureText      = false,
    this.autofocus        = false,
    this.insideLabel      = false,
    this.readOnly         = false,
    this.required         = false,
    this.hidden           = false,
    this.keyBoardType     = TextInputType.text,
    this.inputFormatters,
    this.suffixIcon,
    this.suffixColor      = Colors.deepOrangeAccent,
    this.labelColor       = Colors.black,
    this.elevation        = 1,
    this.borderRadius,
    this.height,
    this.width,
    this.padding,
    this.maxLength,
  });

  @override
  State<SimpleTextField> createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  late bool _passwordVisibility;

  @override
  void initState() {
    super.initState();
    _passwordVisibility = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hidden) return Container();
    if (widget.padding != null) return Padding(padding: widget.padding!, child: getWidget());

    return getWidget();
  }

  Column getWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleWidget.customText(
          text: widget.label,
          required: widget.required,
          disable: widget.readOnly,
          bold: true,
          customColor: widget.labelColor,
          hide: widget.insideLabel || widget.label.isEmpty,
        ),
        Material(
          elevation: widget.elevation,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
          ),
          child: Container(
            width: widget.width,
            padding: const EdgeInsets.only(left: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
              border: Border.all(color: AppColors.black.color),
              color: AppColors.white.color,
            ),
            child: ReactiveTextField(
              readOnly: widget.readOnly,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: widget.keyBoardType,
              formControlName: widget.formControlName,
              inputFormatters: widget.inputFormatters ?? [],
              obscureText: widget.obscureText && _passwordVisibility,
              maxLength: widget.maxLength,
              autofocus: widget.autofocus,

              style: AppTextStyle.custom(
                size: FontSize.middleBig,
                disable: widget.readOnly,
                color: AppColors.black,
              ),

              decoration: InputDecoration(
                border: InputBorder.none,
                errorStyle: const TextStyle(height: 0.01, color: Colors.transparent),
                counterText: widget.counterText,
                suffixIcon: _getSuffixIcon(),
                hintText: widget.required ? AppString.required : widget.hint,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getSuffixIcon() {
    if (widget.obscureText) {
      return GestureDetector(
        onTap: () => setState(() => _passwordVisibility = !_passwordVisibility),
        child: Icon(
          _passwordVisibility ? Icons.visibility_outlined : Icons.visibility_off,
          size: 24,
          color: AppColors.black.color,
        ),
      );
    }

    return Icon(widget.suffixIcon ?? widget.suffixIcon, color: widget.suffixColor);
  }
}