import 'package:flutter/material.dart';
import 'package:project_calendar_manager/database/classes/events.dart';
import 'package:project_calendar_manager/database/db.dart';
import 'package:project_calendar_manager/enums/db.dart';
import 'package:project_calendar_manager/widget/new_event_dialog.dart';

class CalendarS {
  final _db = DBApp.instance;

  Future<Map<DateTime, List<EventsC>>> getEvents(DateTime date) async {
    final query = await _db.dbSelect(table: TABLES.events);

    List<EventsC> events = [];
    for (Map<String, dynamic> map in query) {
      events.add(EventsC.fromMap(map));
    }

    if (events.isEmpty) return {};

    List<DateTime> dates = [];

    for (EventsC event in events) {
      if (!dates.contains(event.date)) dates.add(event.date);
    }

    Map<DateTime, List<EventsC>> result = {
      for (var value in dates) value : _handleEvents(date, events)
    };

    return result;
  }

  void newEvent(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) => const NewEventDialog(),
    );
  }

  List<EventsC> _handleEvents(DateTime date, List<EventsC> events) {
    List<EventsC> dots = [];

    for (EventsC event in events) {
      if (date == event.date) dots.add(event);
    }

    return dots;
  }
}