import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iFit/classes/exercicio.dart';
import 'package:iFit/components/colors/app_colors.dart';

class SquareTreino extends StatelessWidget {
  final Function()? onPressed;
  final RxBool isSelected;
  final Exercicio exercicio;

  const SquareTreino({
    super.key,
    required this.exercicio,
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
                exercicio.imgPath,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * 0.48,
                height: MediaQuery.of(context).size.height,
              ),
              SizedBox(width: 10), // Espaço entre a imagem e o texto
              // Texto à direita
              Flexible(
                child: Text(
                  '${exercicio.nome}',
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
