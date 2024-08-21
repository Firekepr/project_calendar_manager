import 'package:flutter/material.dart';
import 'package:project_calendar_manager/providers/calendar_provider.dart';
import 'package:project_calendar_manager/service/context/ContextService.dart';
import 'package:provider/provider.dart';

class PHelper {

  static CalendarProvider getCalendarProvider(BuildContext? context) {
    return Provider.of<CalendarProvider>(context ?? ContextService.context, listen: false);
  }

}