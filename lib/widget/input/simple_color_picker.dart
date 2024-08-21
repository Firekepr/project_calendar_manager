import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:project_calendar_manager/service/utils/utils.dart';
import 'package:project_calendar_manager/styles/colors/app_colors.dart';
import 'package:project_calendar_manager/styles/colors/app_colors_extension.dart';
import 'package:project_calendar_manager/styles/font/font_size.dart';
import 'package:project_calendar_manager/widget/simple.dart';

class SimpleColorPicker extends StatefulWidget {
  final Color selectedColor;
  final String label;
  final void Function(Color) changeColor;

  const SimpleColorPicker({
    super.key,
    required this.selectedColor,
    required this.label,
    required this.changeColor
  });

  @override
  State<SimpleColorPicker> createState() => _SimpleColorPickerState();
}

class _SimpleColorPickerState extends State<SimpleColorPicker> {
  bool changePallet = false;

  final pallet1 = [
    ColorTools.createPrimarySwatch(UtilsS.fromHex('#bee4e7')),
    ColorTools.createPrimarySwatch(UtilsS.fromHex('#9ddbf0')),
    ColorTools.createPrimarySwatch(UtilsS.fromHex('#d3bedd')),
    ColorTools.createPrimarySwatch(UtilsS.fromHex('#f4cfe1')),
    ColorTools.createPrimarySwatch(UtilsS.fromHex('#f8c9d3')),
    ColorTools.createPrimarySwatch(UtilsS.fromHex('#fbf6bc')),
  ];

  final pallet2 = [
    ColorTools.createPrimarySwatch(UtilsS.fromHex('#bfd8d4')),
    ColorTools.createPrimarySwatch(UtilsS.fromHex('#8fd5ed')),
    ColorTools.createPrimarySwatch(UtilsS.fromHex('#dbc0e9')),
    ColorTools.createPrimarySwatch(UtilsS.fromHex('#f8c9d3')),
    ColorTools.createPrimarySwatch(UtilsS.fromHex('#f18caa')),
    ColorTools.createPrimarySwatch(UtilsS.fromHex('#fee3b8')),
  ];

  @override
  Widget build(BuildContext context) {
    return SimpleWidget.customContainer(
      bgColor: AppColors.white,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white.color,
        border: Border.all(
          color: AppColors.graphite.color,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => changePallet = !changePallet),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SimpleWidget.customText(
                  text: widget.label,
                  color: AppColors.black,
                  size: FontSize.extraSmall,
                  bold: true,
                ),
                const Icon(Icons.sync_rounded, size: 19.0),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialColorPicker(
                elevation: 2,
                circleSize: 38,
                shrinkWrap: true,
                onColorChange: widget.changeColor,
                selectedColor: widget.selectedColor,
                colors: changePallet ? pallet2 : pallet1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
