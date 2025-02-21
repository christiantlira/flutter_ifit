import 'package:flutter/material.dart';
import 'package:iFit/classes/exercicio.dart';
import 'package:iFit/classes/treino.dart';
import 'package:iFit/components/appbars/app_bar.dart';
import 'package:iFit/components/appbars/bottom_app_bar.dart';
import 'package:iFit/components/colors/app_colors.dart';
import 'package:iFit/components/series_balls.dart';
import 'package:iFit/components/series_slider.dart';

class TreinoTela extends StatefulWidget {
  TreinoTela({super.key});

  @override
  State<TreinoTela> createState() => _TreinoTelaState();
}

class _TreinoTelaState extends State<TreinoTela> {
  late Treino treino;
  bool _isInitialized = false;

  void updateReps(int index, int newValue) {
    setState(() {
      treino.exercicios[index].reps = newValue;
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
                                          Slider(
                                              label: exercicio.reps!.toString(),
                                              value:
                                                  exercicio.reps!.toDouble() ??
                                                      5,
                                              min: 1,
                                              max: 30,
                                              thumbColor: AppColors.primaryRed,
                                              activeColor: AppColors.primaryRed,
                                              inactiveColor:
                                                  AppColors.lightGray,
                                              onChanged: (newValue) =>
                                                  updateReps(
                                                      i, newValue.toInt()))
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
