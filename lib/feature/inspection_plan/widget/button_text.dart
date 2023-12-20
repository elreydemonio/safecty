import 'package:flutter/material.dart';
import 'package:safecty/theme/spacing.dart';

class ExpandedButtonText extends StatelessWidget {
  final String text;

  const ExpandedButtonText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: Spacing.small),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
