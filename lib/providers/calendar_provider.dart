import 'package:flutter/material.dart';
import 'package:project_calendar_manager/database/classes/events.dart';

class CalendarProvider extends ChangeNotifier {

  Map<DateTime, List<dynamic>> _events = {};
  Map<DateTime, List<dynamic>> get events => _events;
  setEvents(Map<DateTime, List<dynamic>> newEvents, {bool silence = false}) {
    _events = newEvents;
    if (!silence) notifyListeners();
  }

  List<EventsC> _eventsDay = [];
  List<EventsC> get eventsDay => _eventsDay;
  setEventsDay(List<EventsC> newEvents, {bool silence = false}) {
    _eventsDay = newEvents;
    if (!silence) notifyListeners();
  }
}