import 'package:flutter/material.dart';
import 'package:iFit/data/models/exercise.dart';
import 'package:iFit/core/constants/app_colors.dart';

class ExerciseTileWorkoutRegistration extends StatelessWidget {
  final Exercise exercise;
  final Widget textfield;

  const ExerciseTileWorkoutRegistration({
    super.key,
    required this.exercise,
    required this.textfield,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.darkGray, borderRadius: BorderRadius.circular(8)),
      height: 200,
      child: Column(
        children: [
          // IMAGEM DO TREINO
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 5),
                Image.asset(
                  exercise.imgPath,
                  fit: BoxFit.fitWidth,
                  height: 80,
                ),
                SizedBox(width: 5),
                Text(
                  exercise.name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
          //SLIDER DE SÉRIES
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Text('Number of sets'),
                      textfield,
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
