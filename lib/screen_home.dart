import 'package:flutter/material.dart';

/// The home screen.
class ScreenHome extends StatefulWidget {
  /// Creates a new [ScreenHome].
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Srot'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(10, (i) => Text('$i')),
      ),
    );
  }
}
