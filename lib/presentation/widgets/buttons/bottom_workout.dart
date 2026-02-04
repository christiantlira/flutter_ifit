import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iFit/data/models/exercise.dart';
import 'package:iFit/core/constants/app_colors.dart';

class MyBottomButton extends StatelessWidget {
  final RxList<Exercise> selecteds;
  const MyBottomButton({super.key, required this.selecteds});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selecteds.length > 1
                    ? '${selecteds.length} exercises selected'
                    : '${selecteds.length} exercise selected',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: 170,
                  decoration: BoxDecoration(
                      color: AppColors.primaryRed,
                      borderRadius: BorderRadius.circular(20)),
                  height: 60,
                  child: Text(
                    'Finish Workout',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
