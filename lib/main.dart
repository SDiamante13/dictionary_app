import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.deepPurple,
      ).copyWith(
        secondary: Colors.lightGreen,
      )),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Dictionary App'),
          ),
          body: Center(child: const Text('Hello World'))),
    );
  }
}