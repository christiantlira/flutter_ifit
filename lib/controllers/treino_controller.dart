import 'package:get/get.dart';
import 'package:iFit/classes/exercicio.dart';
import 'package:iFit/lists/lists.dart';

class TreinoController extends GetxController {
  List<List<Exercicio>> list = [];

  @override
  void onInit() {
    super.onInit();
    for (var musculo in AppLists.exs) {
      List<Exercicio> listExercicio = [];
      List.generate(
        musculo.length,
        (index) => listExercicio.add(Exercicio(
          nome: musculo[index].key,
          imgPath: musculo[index].value,
          isSelected: false.obs,
          series: 3,
        )),
      );
      list.add(listExercicio);
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
