import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login.dart';
import 'register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData.dark().copyWith(
        //scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      //),
      title: '눈송밀집분포도',
      home: Scaffold(
        body: ListView(children: [
          //LoginEmpty(),         
          RegisterEmpty(),
        ]),
      ),
    );
  }
}