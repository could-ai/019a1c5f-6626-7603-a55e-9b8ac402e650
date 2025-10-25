import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viora'),
      ),
      body: const Center(
        child: Text(
          'AI Image & Video Generation',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
