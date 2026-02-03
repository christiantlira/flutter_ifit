import 'package:flutter/material.dart';
import 'package:iFit/data/models/train.dart';

class MyWorkoutCarousel extends StatelessWidget {
  final List<Workout> workouts;

  const MyWorkoutCarousel({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      children: [
        for (Workout workout in workouts)
          GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(
                context,
                '/workout',
                arguments: workout,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 400,
                  alignment: Alignment.center,
                  child: Image.asset(
                    workout.imgPath!,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    workout.name,
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
