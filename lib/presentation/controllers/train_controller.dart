import 'package:get/get.dart';
import 'package:iFit/data/models/exercise.dart';
import 'package:iFit/core/constants/exercise_data.dart';

class WorkoutController extends GetxController {
  List<List<Exercise>> list = [];

  @override
  void onInit() {
    super.onInit();
    for (var muscle in AppLists.exs) {
      List<Exercise> exerciseList = [];
      List.generate(
        muscle.length,
        (index) => exerciseList.add(Exercise(
          name: muscle[index].key,
          imgPath: muscle[index].value,
          isSelected: false.obs,
          sets: 3,
        )),
      );
      list.add(exerciseList);
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
