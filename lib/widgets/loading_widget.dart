import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:safecty/theme/app_animation.dart';
import 'package:safecty/theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.whiteBone,
        child: Center(
          child: Lottie.asset(AppAnimation.loadingAnimation),
        ),
      ),
    );
  }
}
