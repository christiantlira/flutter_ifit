import 'package:flutter/material.dart';
import 'package:iFit/components/colors/app_colors.dart';

class MySignInButton extends StatelessWidget {
  final Function() onTap;
  const MySignInButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 100),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryRed,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          "Entrar",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
