import 'package:flutter/material.dart';
import 'package:iFit/data/models/exercise.dart';
import 'package:iFit/data/models/train.dart';
import 'package:iFit/presentation/widgets/app_bars/app_bar.dart';
import 'package:iFit/presentation/widgets/app_bars/bottom_app_bar.dart';
import 'package:iFit/core/constants/app_colors.dart';
import 'package:iFit/presentation/widgets/common/sets_balls.dart';

// Página de treino: Onde o usuário realiza o treino selecionado
class WorkoutScreen extends StatefulWidget {
  WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late Workout workout;
  bool _isInitialized = false;
  int _selectedImageIndex = -1;

  void _onImageTap(int index) {
    setState(() {
      _selectedImageIndex = index;
    });
  }

  void updateReps(Exercise exercise, int index, int newValue) {
    setState(() {
      if (exercise.repsPerSet == null) {
        exercise.onInitReps();
        exercise.repsController(index);
      }
      exercise.repsPerSet?[index] = newValue;
      exercise.repsControllers?[index].text = newValue.toString();
    });
  }

  void updateLoad(Exercise exercise, int index, int newValue) {
    setState(() {
      if (exercise.load == null) {
        exercise.onInitLoads();
        exercise.loadController(index);
      }
      exercise.load?[index] = newValue;
      exercise.loadControllers?[index].text = newValue.toString();
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      workout = ModalRoute.of(context)!.settings.arguments as Workout;
      _isInitialized = true; // Marca como inicializado
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: MyAppBar(
          isBack: true,
          backButtonRoute: '/home',
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                workout.name,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.73, // 🔥 Altura fixa para o PageView
                width: MediaQuery.of(context).size.width * 0.8,
                child: PageView(
                  controller: PageController(viewportFraction: 0.95),
                  scrollDirection: Axis.vertical,
                  children: workout.exercises.map((exercise) {
                    return Container(
                      color: AppColors.black,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.darkGray,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              child: Column(
                                children: [
                                  Image.asset(
                                    exercise.imgPath,
                                    fit: BoxFit.fitWidth,
                                    height: 180,
                                  ),
                                  Text(
                                    exercise.name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.427,
                              alignment: Alignment.center,
                              child: PageView(
                                controller:
                                    PageController(viewportFraction: 0.95),
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                  exercise.sets,
                                  (i) => Container(
                                    color: AppColors.darkGray,
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.lightGray,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SetsBalls(
                                            total: exercise.sets,
                                            index: i,
                                          ),
                                          Divider(), // DIVISOR ----------------
                                          Text(
                                            'Repetitions',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              //ADICIONAR TEXTFIELD PARA PERSONALIZAR QUANTIDADE DE REPETIÇÕES
                                              SizedBox(
                                                width: 50,
                                                child: TextField(
                                                  onSubmitted: (newValue) =>
                                                      updateReps(
                                                    exercise,
                                                    i,
                                                    int.parse(newValue),
                                                  ),
                                                  controller: exercise
                                                              .repsControllers?[
                                                          i] ??
                                                      exercise
                                                          .repsController(i),
                                                ),
                                              ),
                                              Slider(
                                                  label: exercise.repsPerSet?[i]
                                                          .toString() ??
                                                      exercise
                                                          .onInitReps()
                                                          .toString(),
                                                  value: exercise.repsPerSet?[i]
                                                          .toDouble() ??
                                                      8,
                                                  min: 1,
                                                  max: double.parse(exercise
                                                              .repsControllers![
                                                                  i]
                                                              .text) >
                                                          30
                                                      ? double.parse(exercise
                                                          .repsControllers![i]
                                                          .text)
                                                      : 30,
                                                  thumbColor:
                                                      AppColors.primaryRed,
                                                  activeColor:
                                                      AppColors.primaryRed,
                                                  inactiveColor:
                                                      AppColors.darkGray,
                                                  onChanged: (newValue) =>
                                                      updateReps(
                                                        exercise,
                                                        i,
                                                        newValue.toInt(),
                                                      )),
                                            ],
                                          ),
                                          Divider(), // DIVISOR ----------------
                                          Text(
                                            'Load',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.fitness_center),
                                              SizedBox(width: 5),
                                              SizedBox(
                                                width: 50,
                                                child: TextField(
                                                  onSubmitted: (newValue) =>
                                                      updateLoad(
                                                    exercise,
                                                    i,
                                                    int.parse(newValue),
                                                  ),
                                                  controller: exercise
                                                              .loadControllers?[
                                                          i] ??
                                                      exercise
                                                          .loadController(i),
                                                ),
                                              ),
                                            ],
                                          ), //
                                          Divider(),
                                          Text(
                                            'Difficulty',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(5, (index) {
                                              return GestureDetector(
                                                onTap: () => _onImageTap(index),
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 2.0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          _selectedImageIndex ==
                                                                  index
                                                              ? Colors.blue
                                                              : Colors
                                                                  .transparent,
                                                      width: 0.2,
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    index == 0
                                                        ? Icons
                                                            .sentiment_very_satisfied
                                                        : index == 1
                                                            ? Icons
                                                                .sentiment_satisfied
                                                            : index == 2
                                                                ? Icons
                                                                    .sentiment_neutral
                                                                : index == 3
                                                                    ? Icons
                                                                        .sentiment_dissatisfied
                                                                    : Icons
                                                                        .sentiment_very_dissatisfied,
                                                    color:
                                                        _selectedImageIndex ==
                                                                index
                                                            ? Colors.blue
                                                            : Colors.white,
                                                    size: 50,
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                          Divider()
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomAppBar(),
      ),
    );
  }
}
