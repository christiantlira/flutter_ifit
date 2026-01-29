import 'package:flutter/material.dart';
import 'package:iFit/data/models/exercicio.dart';
import 'package:iFit/data/models/treino.dart';
import 'package:iFit/presentation/widgets/app_bars/app_bar.dart';
import 'package:iFit/presentation/widgets/app_bars/bottom_app_bar.dart';
import 'package:iFit/core/constants/app_colors.dart';
import 'package:iFit/presentation/widgets/common/series_balls.dart';
import 'package:iFit/presentation/widgets/forms/text_field_cadastro_treino.dart';

class TreinoTela extends StatefulWidget {
  TreinoTela({super.key});

  @override
  State<TreinoTela> createState() => _TreinoTelaState();
}

class _TreinoTelaState extends State<TreinoTela> {
  late Treino treino;
  bool _isInitialized = false;
  int _selectedImageIndex = -1;

  void _onImageTap(int index) {
    setState(() {
      _selectedImageIndex = index;
    });
  }

  void updateReps(Exercicio exercicio, int index, int newValue) {
    setState(() {
      if (exercicio.serie == null) {
        exercicio.onInitReps();
        exercicio.repsController(index);
      }
      exercicio.serie?[index] = newValue;
      exercicio.controllersReps?[index].text = newValue.toString();
      print('toma esse gap ai ${exercicio.serie?[index]}');
    });
  }

  void updateCarga(Exercicio exercicio, int index, int newValue) {
    setState(() {
      if (exercicio.carga == null) {
        exercicio.onInitCargas();
        exercicio.cargaController(index);
      }
      exercicio.carga?[index] = newValue;
      exercicio.controllersCarga?[index].text = newValue.toString();
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      treino = ModalRoute.of(context)!.settings.arguments as Treino;
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
                treino.nome,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.73, // 🔥 Altura fixa para o PageView
                width: MediaQuery.of(context).size.width * 0.8,
                child: PageView(
                  controller: PageController(viewportFraction: 0.95),
                  scrollDirection: Axis.vertical,
                  children: treino.exercicios.map((exercicio) {
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
                                    exercicio.imgPath,
                                    fit: BoxFit.fitWidth,
                                    height: 180,
                                  ),
                                  Text(
                                    exercicio.nome,
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
                                  exercicio.series,
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
                                          SeriesBalls(
                                            total: exercicio.series,
                                            index: i,
                                          ),
                                          Divider(), // DIVISOR ----------------
                                          Text(
                                            'Repetições',
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
                                                    exercicio,
                                                    i,
                                                    int.parse(newValue),
                                                  ),
                                                  controller: exercicio
                                                              .controllersReps?[
                                                          i] ??
                                                      exercicio
                                                          .repsController(i),
                                                ),
                                              ),
                                              Slider(
                                                  label: exercicio.serie?[i]
                                                          .toString() ??
                                                      exercicio
                                                          .onInitReps()
                                                          .toString(),
                                                  value: exercicio.serie?[i]
                                                          .toDouble() ??
                                                      8,
                                                  min: 1,
                                                  max: double.parse(exercicio
                                                              .controllersReps![
                                                                  i]
                                                              .text) >
                                                          30
                                                      ? double.parse(exercicio
                                                          .controllersReps![i]
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
                                                        exercicio,
                                                        i,
                                                        newValue.toInt(),
                                                      )),
                                            ],
                                          ),
                                          Divider(), // DIVISOR ----------------
                                          Text(
                                            'Carga',
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
                                                      updateCarga(
                                                    exercicio,
                                                    i,
                                                    int.parse(newValue),
                                                  ),
                                                  controller: exercicio
                                                              .controllersCarga?[
                                                          i] ??
                                                      exercicio
                                                          .cargaController(i),
                                                ),
                                              ),
                                            ],
                                          ), //
                                          Divider(),
                                          Text(
                                            'Dificuldade',
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
