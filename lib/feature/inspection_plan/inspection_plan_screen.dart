import 'package:flutter/material.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/font_family.dart';

class InspectionPlanScreen extends StatelessWidget {
  const InspectionPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Center(
        child: Text(
          "Pantall de inspecciones ",
          style: TextStyle(
            color: AppColors.black,
            fontFamily: AppFontFamily.quicksand,
            fontSize: 50.0,
          ),
        ),
      ),
    );
  }
}
