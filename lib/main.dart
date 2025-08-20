import 'package:flutter/material.dart';

void main() {
  runApp(const Srot());
}

/// The main app.
class Srot extends StatelessWidget {
  /// Creates a new [Srot].
  const Srot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(),
    );
  }
}
