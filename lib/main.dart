import 'package:flutter/material.dart';

void main() {
  runApp(const SafariBookingApp());
}

class SafariBookingApp extends StatelessWidget {
  const SafariBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سافر',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('سافر'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'مرحباً بك في تطبيق سافر',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
