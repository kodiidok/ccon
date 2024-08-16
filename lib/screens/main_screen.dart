import 'package:flutter/material.dart';
import 'converter_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the ConverterScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ConverterScreen(),
              ),
            );
          },
          child: const Text('Go to Converter Screen'),
        ),
      ),
    );
  }
}
