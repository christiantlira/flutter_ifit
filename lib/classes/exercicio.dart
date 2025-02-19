import 'package:get/get.dart';

class Exercicio {
  final String imgPath;
  final String nome;
  int? index;
  int series = 3;
  RxBool? isSelected = false.obs;
  Exercicio({
    required this.nome,
    required this.imgPath,
    this.isSelected,
  });
}
