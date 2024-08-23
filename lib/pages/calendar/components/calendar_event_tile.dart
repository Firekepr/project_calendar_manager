import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:project_calendar_manager/database/classes/events.dart';
import 'package:project_calendar_manager/service/utils/utils.dart';
import 'package:project_calendar_manager/styles/colors/app_colors.dart';
import 'package:project_calendar_manager/styles/colors/app_colors_extension.dart';
import 'package:project_calendar_manager/widget/simple.dart';

class CalendarEventTile extends StatelessWidget {
  final EventsC item;
  final void Function() onFavorite;
  final void Function() onTrash;

  const CalendarEventTile({
    super.key,
    required this.item,
    required this.onFavorite,
    required this.onTrash,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleWidget.customContainer(
      borderWidth: 2,
      bdColor: AppColors.black,
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      // padding: const EdgeInsets.only(bottom: 1.0),
      borderRadius: 6.0,
      child: ListTile(
        dense: true,
        tileColor: UtilsS.fromHex(item.color),
        title: Text(item.description),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
        leading: IconButton(
          onPressed: onFavorite,
          color: AppColors.yellow.color,
          icon: DecoratedIcon(
            icon: Icon(
              item.favorite ? Icons.star : Icons.star_border,
              color: item.favorite ? AppColors.yellowDark.color : AppColors.black.color,
            ),
            decoration: IconDecoration(
              border: IconBorder(
                color: Colors.black,
                width: item.favorite ? 4.0 : 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
