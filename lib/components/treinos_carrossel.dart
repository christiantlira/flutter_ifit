import 'package:flutter/material.dart';
import 'package:iFit/classes/exercicio.dart';
import 'package:iFit/components/colors/app_colors.dart';
import 'package:iFit/classes/treino.dart';

class MyTreinoCarousel extends StatelessWidget {
  final List<Treino> treinos;

  const MyTreinoCarousel({super.key, required this.treinos});

  @override
  Widget build(BuildContext context) {
    return treinos.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 80,
                color: AppColors.lightGray,
              ),
              Text(
                "Adicione seus treinos",
                style: TextStyle(
                  color: AppColors.lightGray,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        : CarouselView.weighted(
            flexWeights: [1, 7, 1],
            children: [
              for (Treino treino in treinos)
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        treino.exercicios![0].imgPath,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        treino.nome,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
            ],
          );
  }
}
