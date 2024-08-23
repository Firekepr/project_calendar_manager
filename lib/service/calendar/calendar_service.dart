import 'package:flutter/material.dart';
import 'package:project_calendar_manager/database/classes/events.dart';
import 'package:project_calendar_manager/database/db.dart';
import 'package:project_calendar_manager/enums/db.dart';
import 'package:project_calendar_manager/providers/provider_helper.dart';
import 'package:project_calendar_manager/service/global.dart';
import 'package:project_calendar_manager/widget/new_event_dialog.dart';

class CalendarS {
  final _db = DBApp.instance;

  Future<void> getMonthEvents() async {
    final dt = Global.selectedDay;
    final lastDay = DateTime(dt.year, dt.month + 1, 0).day;
    final date = dt.toString().substring(0, 7);

    final query = await _db.dbSelect(
      table: TABLES.events,
      where: ''' date(t1.date) between date('$date-01') and date('$date-$lastDay') ''',
      orderBy: 'date(t1.date), t1.color'
    );

    List<EventsC> events = [];
    for (Map<String, dynamic> map in query) {
      events.add(EventsC.fromMap(map));
    }

    if (events.isEmpty) return;

    List<DateTime> dates = [];

    for (EventsC event in events) {
      if (!dates.contains(event.date)) dates.add(event.date);
    }

    Map<DateTime, List<EventsDots>> result = {
      for (var value in dates) value : _handleEvents(value, events)
    };

    PHelper.getCalendarProvider(null).setEvents(result);
  }

  Future<void> getDayEvents() async {
    final query = await _db.dbSelect(
        table: TABLES.events,
        where: ''' date = date('${Global.selectedDay}') AND trash = 0''',
        orderBy: 't1.favorite desc, t1.event_order, t1.color'
    );

    List<EventsC> events = [];
    for (Map<String, dynamic> map in query) {
      events.add(EventsC.fromMap(map));
    }

    PHelper.getCalendarProvider(null).setEventsDay(events);
  }

  void newEvent(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) => const NewEventDialog(),
    );
  }

  List<EventsDots> _handleEvents(DateTime date, List<EventsC> events) {
    List<EventsDots> dots = [];

    for (EventsC event in events) {
      if (date == event.date) {
        final idx = dots.indexWhere((e) => e.color == event.color);

        if (idx == -1) {
          dots.add(EventsDots(count: 1, color: event.color));
        } else {
          dots[idx].count = dots[idx].count + 1;
        }
      }
    }

    return dots;
  }

  Future<void> saveEvent(Map<String, dynamic> item, BuildContext context) async {
    final query = await _db.dbSelect(
      table: TABLES.events,
      returned: 'max(t1.event_order) as qt',
      where: ''' date(date) = date('${Global.selectedDay}') ''',
      orderBy: 't1.color',
      limit: 1,
    );

    item['event_order'] = (query.isEmpty || query[0]['qt'] == null) ? 1 : (query[0]['qt'] + 1);

    await _db.dbInsert(table: TABLES.events, values: item);
    await getMonthEvents();

    if (item['date'] == Global.selectedDay.toString().substring(0, 10)) await getDayEvents();

    if (context.mounted) Navigator.pop(context);
  }
}