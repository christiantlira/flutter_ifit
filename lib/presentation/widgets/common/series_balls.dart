import 'package:flutter/material.dart';
import 'package:iFit/core/constants/app_colors.dart';

class SeriesBalls extends StatelessWidget {
  final int total;
  final int index;
  const SeriesBalls({super.key, required this.total, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.height * 0.6,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < total; i++)
            if (i < index)
              //BOLA C COR BROCHA
              Icon(
                Icons.circle,
                color: AppColors.primaryRed,
                size: 10,
              )
            else if (i == index)
              //BOLA COR DO APP
              Icon(
                Icons.circle,
                color: AppColors.primaryRed,
                size: 20,
              )
            else
              //BOLA CINZA
              Icon(
                Icons.circle,
                color: Colors.grey,
                size: 10,
              )
        ],
      ),
    );
  }
}
