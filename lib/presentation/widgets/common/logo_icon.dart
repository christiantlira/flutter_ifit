import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class MyIcon extends StatelessWidget {
  final double size;
  final int? offset;
  const MyIcon({super.key, required this.size, this.offset});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size * 3 / size),
      width: size * 1.5,
      height: size * 1.5,
      decoration: BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryRed,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Expanded(
          child: Transform.rotate(
            angle: 135 * (pi / 180),
            child: Icon(
              shadows: [
                Shadow(
                    color: Colors.black,
                    offset: Offset(-2, -2),
                    blurRadius: 0.5)
              ],
              color: Colors.white,
              Icons.fitness_center,
              size: size,
            ),
          ),
        ),
      ),
    );
  }
}
