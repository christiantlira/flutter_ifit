import 'package:flutter/material.dart';
import 'package:iFit/components/colors/app_colors.dart';
import 'package:iFit/components/visual/logo_icon.dart';

class MyBottomAppBar extends StatelessWidget {
  final Function()? onHomePressed;
  final Function()? onProfilePressed;
  final Function()? onSettingsPressed;

  const MyBottomAppBar({
    super.key,
    this.onHomePressed,
    this.onProfilePressed,
    this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 90, // Altura da BottomAppBar
          width: MediaQuery.of(context).size.width * 0.75, // 70% da largura
          decoration: BoxDecoration(
            color: Colors.transparent, // Cor da barra
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              //TODOS CONTAINER DA ESQUERDA
              Container(
                width: MediaQuery.of(context).size.width * 0.2625,
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.darkGray,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    FittedBox(
                      child: GestureDetector(
                        child: Icon(
                          shadows: [
                            Shadow(
                              color: Colors.black
                                  .withOpacity(0.5), // Cor da sombra
                              blurRadius: 4, // Suavização da sombra
                              offset: Offset(5, 5), // Posição da sombra (X, Y)
                            )
                          ],
                          size: 100,
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    FittedBox(
                      child: GestureDetector(
                        child: Icon(
                          shadows: [
                            Shadow(
                              color: Colors.black
                                  .withValues(alpha: 0.5), // Cor da sombra
                              blurRadius: 4, // Suavização da sombra
                              offset: Offset(5, 5), // Posição da sombra (X, Y)
                            )
                          ],
                          size: 100,
                          Icons.star,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 5),
              //TODOS CONTAINER DO MEIO
              GestureDetector(
                child: MyIcon(size: 50),
              ),
              SizedBox(width: 5),
              //TODOS CONTAINER DA DIREITA
              Container(
                width: MediaQuery.of(context).size.width * 0.2625,
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.darkGray,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    FittedBox(
                      child: GestureDetector(
                        child: Icon(
                          shadows: [
                            Shadow(
                              color: Colors.black
                                  .withOpacity(0.5), // Cor da sombra
                              blurRadius: 4, // Suavização da sombra
                              offset: Offset(5, 5), // Posição da sombra (X, Y)
                            )
                          ],
                          size: 100,
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    FittedBox(
                      child: GestureDetector(
                        child: Icon(
                          shadows: [
                            Shadow(
                              color: Colors.black
                                  .withValues(alpha: 0.5), // Cor da sombra
                              blurRadius: 4, // Suavização da sombra
                              offset: Offset(5, 5), // Posição da sombra (X, Y)
                            )
                          ],
                          size: 100,
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
