import 'package:flutter/material.dart';
import 'package:nunsong/screens/home_screen.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..userAgent =
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36';
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFFF7F8FA),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF111827),
          ),
        ),
        cardColor: const Color(0xFFFAFBFB),
      ),
      home: const HomeScreen(),
    );
  }
}
