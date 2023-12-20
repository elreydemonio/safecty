import 'package:flutter/material.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/spacing.dart';

class SnackBarWidget extends StatelessWidget {
  const SnackBarWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  SnackBar build(BuildContext context) {
    return SnackBar(
      backgroundColor: AppColors.orange,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(
        horizontal: Spacing.medium,
        vertical: Spacing.xLarge + Spacing.medium,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            3.0,
          ),
        ),
      ),
    );
  }
}
