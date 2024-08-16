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
        ],
      ),
    );
  }
}
