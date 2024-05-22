import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:project_calendar_manager/styles/colors/app_colors.dart';
import 'package:project_calendar_manager/styles/colors/app_colors_extension.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final Map<DateTime, List<dynamic>> events;
  final DateTime selectedDay;
  final CalendarFormat currentFormat;
  final void Function(DateTime time1, DateTime time2) onDaySelected;
  final void Function(DateTime time) onPageChanged;
  final void Function(CalendarFormat format) onFormatChanged;

  const Calendar({
    super.key,
    required this.events,
    required this.selectedDay,
    required this.currentFormat,
    required this.onDaySelected,
    required this.onPageChanged,
    required this.onFormatChanged,
  });

  @override
  Widget build(BuildContext context) {
    const chevronMargin = EdgeInsets.symmetric(horizontal: 12.0);
    final primaryColor = Theme.of(context).primaryColor;

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

      headerStyle: HeaderStyle(
        titleTextFormatter: _getHeaderTitle,
        titleTextStyle: TextStyle(
          fontSize: 16.0,
          color: AppColors.white.color,
          fontWeight: FontWeight.bold,
        ),

        rightChevronPadding: EdgeInsets.zero,
        rightChevronMargin: chevronMargin,
        leftChevronMargin: chevronMargin,
        leftChevronPadding: EdgeInsets.zero,

        titleCentered: false,
        formatButtonVisible: true,
        formatButtonShowsNext: true,

        decoration: BoxDecoration(color: primaryColor),

        formatButtonTextStyle: const TextStyle(color: Colors.white, fontSize: 12.0),
        formatButtonDecoration: BoxDecoration(
          border: Border.all(color: AppColors.white.color),
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),

        leftChevronIcon: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 36,
        ),
        rightChevronIcon: const Icon(
          Icons.chevron_right,
          color: Colors.white,
          size: 36,
        ),
      ),

      calendarStyle: CalendarStyle(
        todayTextStyle: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),

        selectedTextStyle: TextStyle(
          color: AppColors.white.color,
          fontWeight: FontWeight.bold,
        ),

        weekendTextStyle: TextStyle(color: AppColors.red.color),

        cellPadding: const EdgeInsets.only(top: 0.0),

        outsideDaysVisible: true,
        isTodayHighlighted: true,

        selectedDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primaryColor,
        ),

        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: primaryColor),
        ),
      ),

      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: AppColors.black.color, fontSize: 14),
        weekendStyle: TextStyle(color: AppColors.red.color, fontSize: 14),
        // dowTextFormatter: (date, locale) => _getDayOfWeekText(date, locale),
      ),
    );
  }

  List<dynamic> _getEvents(DateTime date) {
    DateTime day = DateTime.parse(date.toString().substring(0, date.toString().length - 1));

    return events[day] ?? [];
  }

  String _getDayOfWeekText(DateTime date, dynamic locale) {
    String day = DateFormat('EEEE', locale).format(date);
    return day[0].toUpperCase();
  }

  String _getHeaderTitle(DateTime date, dynamic locale) {
    String title = DateFormat('MMMM', locale).format(date);
    return '${title.replaceFirst(RegExp(title[0]), title[0].toUpperCase(), 0)} - ${date.year}';
  }
}
