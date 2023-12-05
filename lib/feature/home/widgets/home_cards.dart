import 'package:flutter/material.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/font_family.dart';
import 'package:safecty/theme/spacing.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.icon,
    required this.onTap,
    required this.title,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        color: AppColors.whiteBone,
        height: size.height * 0.22,
        padding: const EdgeInsets.all(Spacing.small),
        width: size.width * 0.44,
        child: Column(
          children: [
            const SizedBox(
              height: Spacing.xLarge,
            ),
            Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  border: Border.all(
                    width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: AppColors.white,
                    size: 40.0,
                  ),
                )),
            const SizedBox(
              height: Spacing.medium,
            ),
            const Divider(
              thickness: 2.0,
            ),
            const SizedBox(
              height: Spacing.small,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black,
                fontFamily: AppFontFamily.quicksand,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
