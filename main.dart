import 'package:flutter/material.dart';
import 'auto_parts_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Магазин автозапчастей',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AutoPartsList(),
    );
  }
}
