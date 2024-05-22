import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime selectedDay;
  final CalendarFormat currentFormat;
  final void Function(DateTime time1, DateTime time2) onDaySelected;
  final void Function(DateTime time) onPageChanged;
  final void Function(CalendarFormat format) onFormatChanged;

  const Calendar({
    super.key,
    required this.selectedDay,
    required this.currentFormat,
    required this.onDaySelected,
    required this.onPageChanged,
    required this.onFormatChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final availableCalendarFormats = {
      CalendarFormat.month: 'Mês',
      CalendarFormat.week: 'Sem',
      CalendarFormat.twoWeeks: 'Duas sem',
    };

    return TableCalendar(
      firstDay: DateTime.utc(2000, 01, 01),
      lastDay: DateTime.utc(2099, 10, 20),
      focusedDay: selectedDay,
      locale: 'pt-Br',
      calendarFormat: currentFormat,
      eventLoader: _getEvents,
      availableCalendarFormats: availableCalendarFormats,
      onDaySelected: onDaySelected,
      onPageChanged: onPageChanged,
      onFormatChanged: onFormatChanged,
      availableGestures: AvailableGestures.all,
      daysOfWeekHeight: screenHeight * 0.022,
      rowHeight: screenHeight * 0.057,

      selectedDayPredicate: (DateTime date) => isSameDay(selectedDay, date),

      headerVisible: true,
      pageJumpingEnabled: true,
      pageAnimationEnabled: true,
      daysOfWeekVisible: true,
    );
  }

  List<dynamic> _getEvents(DateTime date) {
    DateTime day = DateTime.parse(date.toString().substring(0, date.toString().length - 1));

    return [];
  }
}
