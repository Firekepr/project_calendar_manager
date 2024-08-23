import 'package:flutter/cupertino.dart';
import 'package:project_calendar_manager/database/classes/events.dart';
import 'package:project_calendar_manager/database/db.dart';
import 'package:project_calendar_manager/enums/db.dart';
import 'package:project_calendar_manager/service/calendar/calendar_service.dart';
import 'package:project_calendar_manager/service/utils/dialog_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsS {
  final _db = DBApp.instance;
  final _calendar = CalendarS();

  Future<void> onFavorite(EventsC events) async {
    events.favorite = !events.favorite;

    await _db.dbUpdate(
      table: TABLES.events,
      values: events.toMap(),
      where: 'id=?',
      whereArgs: events.id
    );

    await _calendar.getDayEvents();
  }

  Future<void> onTrash(BuildContext context, EventsC events) async {
    final response = await DialogUtils.showNewConfirmDialog(
      context: context,
      header: AppLocalizations.of(context)!.attention,
      message: AppLocalizations.of(context)!.toTrashDescription,
      confirmButtonLabel: AppLocalizations.of(context)!.toTrash,
      cancelButtonLabel: AppLocalizations.of(context)!.cancel,
    );

    if (!response) return;

    await _db.dbUpdate(
      table: TABLES.events,
      values: events.toMap(trash: true),
      where: 'id=?',
      whereArgs: events.id,
    );

    await _calendar.getDayEvents();
    await _calendar.getMonthEvents();
  }
}