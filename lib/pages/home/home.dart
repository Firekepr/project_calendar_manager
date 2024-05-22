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

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _onDayChange(DateTime date1, DateTime date2) {
   setState(() => selectedDay = date1 );
  }

  void _onFormatChange(CalendarFormat format) {
    setState(() => currentFormat = format );
  }
}