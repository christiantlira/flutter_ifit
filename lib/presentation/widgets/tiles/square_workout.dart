import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iFit/data/models/exercise.dart';
import 'package:iFit/core/constants/app_colors.dart';

class SquareWorkout extends StatelessWidget {
  final Function()? onPressed;
  final RxBool isSelected;
  final Exercise exercise;

  const SquareWorkout({
    super.key,
    required this.exercise,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.darkGray),
            borderRadius: BorderRadius.circular(8),
            color:
                isSelected.value ? AppColors.primaryRed : AppColors.lightGray,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Imagem à esquerda
              Image.asset(
                exercise.imgPath,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * 0.48,
                height: MediaQuery.of(context).size.height,
              ),
              SizedBox(width: 10), // Espaço entre a imagem e o texto
              // Texto à direita
              Flexible(
                child: Text(
                  '${exercise.name}',
                  style: TextStyle(
                    color: isSelected.value ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight:
                        isSelected.value ? FontWeight.bold : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2, // Caso o texto ultrapasse o limite
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
