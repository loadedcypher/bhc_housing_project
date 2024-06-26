import 'package:flutter/material.dart';

class Statements extends StatelessWidget {
  const Statements({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statements'),
        backgroundColor: const Color(0xFFAC2324),
      ),
      body: const Center(
        child: Text('This is the Statements page.'),
      ),
    );
  }
}