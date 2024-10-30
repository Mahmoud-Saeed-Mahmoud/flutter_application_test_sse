import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> events = [];

  late final EventSource eventSource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) => ListTile(title: Text(events[index])),
      ),
    );
  }

  @override
  void dispose() {
    eventSource.close();
    super.dispose();
  }

  void fetchEvents() async {
    eventSource = EventSource('http://localhost:3000/events/stream');

    eventSource.onMessage.listen((event) {
      log('event: $event', name: 'EventSource');
      if (event.data != null) {
        // setState(
        //   () {
        //     events.add(event.data!); // Store the received data
        //   },
        // );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }
}
