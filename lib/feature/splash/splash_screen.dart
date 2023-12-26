import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:safecty/core/navigation/named_route.dart';
import 'package:safecty/theme/app_animation.dart';
import 'package:safecty/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    starTimer();
  }

  starTimer() {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() => Navigator.of(context)
      .pushReplacementNamed(NamedRoute.inspectionCheckScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: content(),
    );
  }

  Widget content() {
    return Center(
      child: Lottie.asset(AppAnimation.splashAnimation),
    );
  }
}
