import 'package:flutter/material.dart';
import 'package:iFit/data/models/exercicio.dart';
import 'package:iFit/core/constants/app_colors.dart';

class ExercicioTileCadastroTreino extends StatelessWidget {
  final Exercicio exercicio;
  final Widget textfield;

  const ExercicioTileCadastroTreino({
    super.key,
    required this.exercicio,
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
                  exercicio.imgPath,
                  fit: BoxFit.fitWidth,
                  height: 80,
                ),
                SizedBox(width: 5),
                Text(
                  exercicio.nome,
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
                      Text('Quantidade de séries'),
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
