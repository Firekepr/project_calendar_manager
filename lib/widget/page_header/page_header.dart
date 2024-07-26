import 'package:flutter/material.dart';
import 'package:project_calendar_manager/styles/colors/app_colors.dart';
import 'package:project_calendar_manager/styles/colors/app_colors_extension.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final Widget? trailing;
  final void Function()? goBack;
  final bool hideBack;
  final double topBorderRadius;
  final double titleSize;
  final AppColors titleColor;
  final AppColors iconColor;

  const PageHeader({
    super.key,
    required this.title,
    this.goBack,
    this.titleStyle,
    this.trailing,
    this.hideBack = false,
    this.titleSize = 18.0,
    this.topBorderRadius = 0.0,
    this.titleColor = AppColors.white,
    this.iconColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(topBorderRadius),
          topLeft: Radius.circular(topBorderRadius),
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: hideBack
                  ? const SizedBox(width: 32, height: 32)
                  : InkWell(
                      onTap: goBack ?? () => Navigator.pop(context),
                      child: Icon(
                        Icons.clear_outlined,
                        color: iconColor.color,
                        size: 32.0,
                      ),
                  ),
          ),
          Expanded(
            flex: 11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: titleColor.color,
                    fontSize: titleSize,
                  ),
                ),
              ],
            ),
          ),
          trailing ?? const Expanded(
              flex: 1,
              child: SizedBox(width: 16)
          ),
        ],
      ),
    );
  }
}
