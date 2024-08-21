import 'package:flutter/material.dart';
import 'package:project_calendar_manager/pages/calendar/calendar.dart';
import 'package:project_calendar_manager/pages/home/components/drawer.dart';
import 'package:project_calendar_manager/providers/calendar_provider.dart';
import 'package:project_calendar_manager/service/calendar/calendar_service.dart';
import 'package:project_calendar_manager/service/global.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _service = CalendarS();

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
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          drawer: const AppDrawer(),
          body: Calendar(
            selectedDay: Global.selectedDay,
            onDaySelected: _onDayChange,
            currentFormat: currentFormat,
            onFormatChanged: _onFormatChange,
            onPageChanged: (date) => {},
            events: p.events,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _service.newEvent(context),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _onDayChange(DateTime date1, DateTime date2) {
   setState(() => Global.selectedDay = date1 );
  }

  void _onFormatChange(CalendarFormat format) {
    setState(() => currentFormat = format );
  }

  Future<void> _getEvents() async {
     await _service.getEvents();
  }
}