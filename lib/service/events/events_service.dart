import 'package:project_calendar_manager/database/classes/events.dart';
import 'package:project_calendar_manager/database/db.dart';
import 'package:project_calendar_manager/enums/db.dart';
import 'package:project_calendar_manager/service/calendar/calendar_service.dart';

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
}