import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SquareTile extends StatelessWidget {
  final Function()? onPressed;
  final String imgPath;
  const SquareTile({super.key, required this.imgPath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(1000),
            color: Colors.white),
        child: Image.asset(
          fit: BoxFit.cover,
          imgPath,
          height: 50,
        ),
      ),
    );
  }
}
