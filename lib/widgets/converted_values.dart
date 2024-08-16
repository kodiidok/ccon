import 'package:ccon/widgets/converted_value.dart';
import 'package:flutter/material.dart';

class ConvertedValues extends StatelessWidget {
  const ConvertedValues({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConvertedValue(),
          // // Example content
          // Container(
          //   height: 200, // Example fixed height, adjust as needed
          //   color: Colors.red,
          //   child: Center(child: Text('Some content')),
          // ),
          // SizedBox(height: 16),
          // Container(
          //   height: 200, // Example fixed height, adjust as needed
          //   color: Colors.blue,
          //   child: Center(child: Text('Some more content')),
          // ),
          // Add more widgets as needed
        ],
      ),
    );
  }
}
