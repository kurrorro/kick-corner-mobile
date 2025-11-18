import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:kick_corner/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFB02A29),
    ).copyWith(
      primary: const Color(0xFF111827), // AppBar, drawer header
      secondary: const Color(0xFFB02A29), // tombol utama
      surface: const Color(0xFFF9FAFB), // background
    );

    return Provider<CookieRequest>(
      create: (_) => CookieRequest(),
      child: MaterialApp(
        title: 'Kick Corner',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: colorScheme,
          scaffoldBackgroundColor: colorScheme.surface,
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: colorScheme.surface,
            foregroundColor: const Color(0xFF111827),
            elevation: 0,
            centerTitle: false,
          ),
        ),
        home: const LoginApp(),
      ),
    );
  }
}
