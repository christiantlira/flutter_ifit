import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class MyLogo extends StatelessWidget {
  final double size;
  const MyLogo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'i',
          style: TextStyle(
            fontFamily: 'Avatar',
            fontSize: size,
            color: AppColors.primaryRed,
          ),
        ),
        Text(
          'Fit',
          style: TextStyle(
            fontFamily: 'Avatar',
            fontSize: size,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
