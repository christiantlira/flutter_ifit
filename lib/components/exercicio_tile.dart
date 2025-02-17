import 'package:flutter/material.dart';
import 'package:iFit/classes/exercicio.dart';
import 'package:iFit/components/colors/app_colors.dart';

class ExercicioTile extends StatelessWidget {
  final Exercicio exercicio;
  final int valorAtual;
  final Function(String, int) onValorMudou;

  const ExercicioTile({
    super.key,
    required this.exercicio,
    required this.valorAtual,
    required this.onValorMudou,
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
                      Slider(
                        label: valorAtual.toString(),
                        min: 1,
                        max: 10,
                        divisions: 9,
                        value: valorAtual.toDouble(),
                        thumbColor: AppColors.primaryRed,
                        activeColor: AppColors.primaryRed,
                        inactiveColor: AppColors.lightGray,
                        onChanged: (double value) {
                          onValorMudou(exercicio.nome, value.round());
                        },
                      )
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
