import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:iFit/data/models/exercicio.dart';
import 'package:iFit/core/constants/app_colors.dart';
import 'package:iFit/data/models/treino.dart';

class MyTreinoCarousel extends StatelessWidget {
  final List<Treino> treinos;

  const MyTreinoCarousel({super.key, required this.treinos});

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      children: [
        for (Treino treino in treinos)
          GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(
                context,
                '/treino',
                arguments: treino,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 400,
                  alignment: Alignment.center,
                  child: Image.asset(
                    treino.imgPath!,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    treino.nome,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}
