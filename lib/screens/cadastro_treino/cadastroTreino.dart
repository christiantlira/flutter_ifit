import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iFit/classes/exercicio.dart';
import 'package:iFit/components/appbars/app_bar.dart';
import 'package:iFit/components/appbars/bottom_app_bar.dart';
import 'package:iFit/components/appbars/bottom_treino.dart';
import 'package:iFit/components/colors/app_colors.dart';
import 'package:iFit/components/square_treino.dart';
import 'package:iFit/controllers/treino_controller.dart';
import 'package:iFit/lists/lists.dart';

class CadastrarTreino extends GetView<TreinoController> {
  const CadastrarTreino({super.key});

  @override
  Widget build(BuildContext context) {
    // INICIANDO CONTROLLER
    TreinoController treinoController = TreinoController();
    treinoController.onInit();

    RxList<Exercicio> selecteds = <Exercicio>[].obs; // Lista observável

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
                            return SquareTreino(
                              onPressed: () {
                                var exercicio =
                                    treinoController.list[pageIndex][index];
                                exercicio.isSelected!.value =
                                    !exercicio.isSelected!.value;

                                if (exercicio.isSelected!.value) {
                                  selecteds.add(exercicio);
                                } else {
                                  selecteds.remove(exercicio);
                                }
                              },
                              isSelected: treinoController
                                  .list[pageIndex][index].isSelected!,
                              exercicio: treinoController.list[pageIndex]
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
                              context, '/finalizarCadastroTreino',
                              arguments: selecteds);
                        },
                        child: MyBottonButton(selecteds: selecteds))
                    : SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
