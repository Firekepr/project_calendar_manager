import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_calendar_manager/styles/colors/app_colors.dart';
import 'package:project_calendar_manager/styles/colors/app_colors_extension.dart';
import 'package:project_calendar_manager/widget/simple.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SpinCareFormDatePicker extends StatefulWidget {
  final String label;
  final String formControlName;
  final String? hintText;
  final double? width;
  final double? borderRadius;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool? stringDate;
  final InputBorder? inputBorder;
  final TextStyle? labelStyle;
  final IconData? icon;
  final double elevation;
  final EdgeInsets margin;

  const SpinCareFormDatePicker({
    super.key,
    required this.label,
    this.labelStyle,
    required this.formControlName,
    this.hintText,
    this.width,
    this.borderRadius,
    this.firstDate,
    this.lastDate,
    this.stringDate,
    this.inputBorder,
    this.icon,
    this.elevation = 0,
    this.margin = EdgeInsets.zero,
  });

  @override
  State<SpinCareFormDatePicker> createState() => _SpinCareFormDatePickerState();
}

class _SpinCareFormDatePickerState extends State<SpinCareFormDatePicker> {
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleWidget.customContainer(
      borderRadius: 10.0,
      elevation: widget.elevation,
      margin: widget.margin,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
        color: AppColors.white.color,
        border: Border.all(
          color: AppColors.graphite.color,
          width: 0.5,
        ),
      ),
      child: ReactiveDatePicker<DateTime>(
        formControlName: widget.formControlName,
        firstDate: widget.firstDate ?? DateTime(2018),
        lastDate: widget.lastDate ?? DateTime(2200),
        builder: (context, picker, child) {
          Widget suffix = InkWell(
            onTap: () {
              _focusNode.unfocus();
              _focusNode.canRequestFocus = false;
              picker.control.value = null;
              Future.delayed(const Duration(milliseconds: 100), () {
                _focusNode.canRequestFocus = true;
              });
            },
            child: const Icon(Icons.clear),
          );

          if (picker.value == null) {
            suffix = Icon(widget.icon ?? Icons.calendar_today);
          }

          return SizedBox(
            width: widget.width ?? MediaQuery.of(context).size.width * 0.40,
            child: ReactiveTextField(
              onTap: (date) {
                if (_focusNode.canRequestFocus) {
                  _focusNode.unfocus();
                  picker.showPicker();
                }
              },
              focusNode: _focusNode,
              formControlName: widget.formControlName,
              readOnly: true,
              decoration: InputDecoration(
                labelText: widget.label,
                hintText: widget.hintText ?? '',
                labelStyle: widget.labelStyle ?? TextStyle(
                  color: AppColors.black.color,
                  fontWeight: FontWeight.bold,
                ),
                border: widget.inputBorder ?? InputBorder.none,
                suffixIcon: suffix,
                errorStyle: const TextStyle(height: 0.01, color: Colors.transparent),
              ),
              valueAccessor: widget.stringDate != null && widget.stringDate!
                  ? DateTimeValueAccessor(dateTimeFormat: DateFormat('dd MMM yyyy'))
                  : DateTimeValueAccessor(dateTimeFormat: DateFormat('dd/MM/yyyy')),
            ),
          );
        },
      ),
    );
  }
}
