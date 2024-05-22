import 'package:flutter/material.dart';
import 'package:project_calendar_manager/pages/calendar/calendar.dart';
import 'package:project_calendar_manager/pages/home/components/drawer.dart';
import 'package:table_calendar/table_calendar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   DateTime selectedDay = DateTime.now();
   CalendarFormat currentFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: const AppDrawer(),
      body: Calendar(
        selectedDay: selectedDay,
        onDaySelected: _onDayChange,
        currentFormat: currentFormat,
        onFormatChanged: _onFormatChange,
        onPageChanged: (date) => {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onDayChange(DateTime date1, DateTime date2) {
   setState(() => selectedDay = date1 );
  }

  void _onFormatChange(CalendarFormat format) {
    setState(() => currentFormat = format );
  }
}