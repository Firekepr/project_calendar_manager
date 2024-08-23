import 'package:flutter/material.dart';
import 'package:project_calendar_manager/pages/calendar/components/calendar.dart';
import 'package:project_calendar_manager/pages/calendar/components/calendar_event_tile.dart';
import 'package:project_calendar_manager/providers/calendar_provider.dart';
import 'package:project_calendar_manager/service/calendar/calendar_service.dart';
import 'package:project_calendar_manager/service/events/events_service.dart';
import 'package:project_calendar_manager/service/global.dart';
import 'package:project_calendar_manager/styles/colors/app_colors.dart';
import 'package:project_calendar_manager/styles/colors/app_colors_extension.dart';
import 'package:project_calendar_manager/widget/simple.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final _service = CalendarS();
  final _eventS = EventsS();

  Color pickerColor = Colors.red;

  CalendarFormat currentFormat = CalendarFormat.month;

  @override
  void initState() {
    _getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarProvider>(
      builder: (context, CalendarProvider p, Widget? body) {
       return Column(
         children: [
           Calendar(
             selectedDay: Global.selectedDay,
             onDaySelected: _onDayChange,
             currentFormat: currentFormat,
             onFormatChanged: _onFormatChange,
             onPageChanged: (date) => {},
             events: p.events,
           ),

           Container(color: AppColors.primary.color, height: 15.0),

           Expanded(
             child: ListView.builder(
               itemCount: p.eventsDay.length,
               shrinkWrap: true,
               itemBuilder: (context, idx) {
                 return CalendarEventTile(
                   item: p.eventsDay[idx],
                   onFavorite: () => _eventS.onFavorite(p.eventsDay[idx]),
                 );
               },
             ),
           ),
         ],
       );
      }
    );
  }

  Future<void> _onDayChange(DateTime date1, DateTime date2) async {
    setState(() => Global.selectedDay = date1 );
    await _service.getDayEvents();
  }

  void _onFormatChange(CalendarFormat format) {
    setState(() => currentFormat = format );
  }

  Future<void> _getEvents() async {
    await _service.getMonthEvents();
  }
}
