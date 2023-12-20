import 'package:flutter/material.dart';

class ExpandedButtonWithTooltip extends StatelessWidget {
  final IconData icon;
  final String tooltipText;
  final VoidCallback onTap;

  const ExpandedButtonWithTooltip({
    super.key,
    required this.icon,
    required this.tooltipText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipText,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: onTap,
          child: Icon(icon),
        ),
      ),
    );
  }
}
