import 'package:flutter/material.dart';
import 'package:safecty/theme/app_colors.dart';

class MyContainerWithElevation extends StatefulWidget {
  final String description;
  final bool check;
  final Function(bool?) isCheck;
  final int index;

  const MyContainerWithElevation({
    super.key,
    required this.index,
    required this.description,
    required this.check,
    required this.isCheck,
  });

  @override
  _MyContainerWithElevationState createState() =>
      _MyContainerWithElevationState();
}

class _MyContainerWithElevationState extends State<MyContainerWithElevation> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange,
              ),
              child: Center(
                child: Text(
                  '${widget.index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.description,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 16),
            Checkbox(
                value: widget.check,
                activeColor: Colors.orange,
                checkColor: AppColors.whiteBone,
                onChanged: widget.isCheck),
          ],
        ),
      ),
    );
  }
}
