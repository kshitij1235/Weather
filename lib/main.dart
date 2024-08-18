import 'package:flutter/material.dart';
import 'package:weather/pages/homepage.dart'; // Ensure this path is correct

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(), // Ensure Homepage is correctly imported and defined
    );
  }
}
