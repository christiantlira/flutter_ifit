import 'package:flutter/material.dart';
import 'package:iFit/classes/exercicio.dart';
import 'package:iFit/components/colors/app_colors.dart';

class MySlider extends StatelessWidget {
  final Exercicio exercicio;
  final Function(int) onChanged;

  const MySlider({super.key, required this.exercicio, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Slider(
      label: exercicio.series.toString(),
      min: 1,
      max: 10,
      divisions: 9,
      value: exercicio.series!.toDouble(),
      thumbColor: AppColors.primaryRed,
      activeColor: AppColors.primaryRed,
      inactiveColor: AppColors.lightGray,
      onChanged: (double newValue) => onChanged(newValue.toInt()),
    );
  }
}
