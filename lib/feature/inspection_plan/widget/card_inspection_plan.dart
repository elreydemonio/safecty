import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/spacing.dart';

class CardInspectionPlan extends StatelessWidget {
  const CardInspectionPlan({
    super.key,
    required this.height,
    required this.width,
    required this.executed,
    required this.total,
    required this.scheduled,
    required this.name,
    required this.onTap,
  });

  final double height;
  final double width;
  final String executed;
  final String total;
  final double scheduled;
  final String name;
  final VoidCallback onTap;

  double convert(double valor, double maximum) {
    double percentage = (valor / maximum).clamp(0, 1);
    double percentageConvert = 1 - percentage;
    return percentageConvert;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.only(bottom: Spacing.medium),
        decoration: BoxDecoration(
          color: AppColors.whiteBone,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 2.0,
              offset: const Offset(0, 2.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60.0,
              margin: const EdgeInsets.only(
                top: Spacing.medium,
                right: Spacing.medium,
                left: Spacing.small,
              ),
              height: 60.0,
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.note_alt_outlined,
                color: Colors.white,
                size: 40.0,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  top: Spacing.medium,
                  bottom: Spacing.medium,
                  right: Spacing.medium,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                      minFontSize: 10,
                      stepGranularity: 10,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Spacing.medium),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          executed,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          total,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.medium),
                    LinearPercentIndicator(
                      lineHeight: 6.0,
                      percent: convert(double.parse(executed), scheduled),
                      backgroundColor: Colors.grey.shade300,
                      progressColor: Colors.greenAccent,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
