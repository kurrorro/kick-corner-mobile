import 'package:flutter/material.dart';
import 'package:kick_corner/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFB02A29),
    ).copyWith(
      primary: const Color(0xFF111827), // AppBar, Drawer
      secondary: const Color(0xFFB02A29), // #b02a29
    );
    return MaterialApp(
      title: 'Kick Corner',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}