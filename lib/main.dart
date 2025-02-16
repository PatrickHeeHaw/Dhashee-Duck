import 'package:flutter/material.dart';
import 'DuckWidget.dart'; // Import the DuckWidget

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DuckWidget(),
    );
  }
}
