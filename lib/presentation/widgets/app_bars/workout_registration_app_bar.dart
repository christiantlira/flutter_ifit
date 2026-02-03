import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iFit/data/models/exercise.dart';
import 'package:iFit/presentation/widgets/app_bars/app_bar.dart';
import 'package:iFit/presentation/widgets/buttons/bottom_workout.dart';
import 'package:iFit/core/constants/app_colors.dart';
import 'package:iFit/presentation/widgets/tiles/square_workout.dart';
import 'package:iFit/presentation/controllers/workout_controller.dart';
import 'package:iFit/core/constants/exercise_data.dart';

class FinishWorkout extends GetView<WorkoutController> {
  const FinishWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    // INICIANDO CONTROLLER
    WorkoutController workoutController = WorkoutController();
    workoutController.onInit();

    RxList<Exercise> selecteds = <Exercise>[].obs; // Lista observável

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: MyAppBar(
          isBack: true,
          backButtonRoute: '/home',
        ),
        body: Stack(
          children: [
            PageView.builder(
              itemCount: AppLists.exs.length,
              itemBuilder: (context, pageIndex) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          AppLists.pageTitles[pageIndex],
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 2.35,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return SquareWorkout(
                              onPressed: () {
                                var exercise =
                                    workoutController.list[pageIndex][index];
                                exercise.isSelected!.value =
                                    !exercise.isSelected!.value;

                                if (exercise.isSelected!.value) {
                                  selecteds.add(exercise);
                                } else {
                                  selecteds.remove(exercise);
                                }
                              },
                              isSelected: workoutController
                                  .list[pageIndex][index].isSelected!,
                              exercise: workoutController.list[pageIndex]
                                  [index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Obx(
              () => AnimatedPositioned(
                right: 0,
                left: 0,
                duration: Duration(milliseconds: 300),
                bottom: selecteds.isNotEmpty ? 0 : -100,
                child: selecteds.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, '/finishWorkoutRegistration',
                              arguments: selecteds);
                        },
                        child: MyBottomButton(selecteds: selecteds))
                    : SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
