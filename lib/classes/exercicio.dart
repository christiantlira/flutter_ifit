import 'package:get/get.dart';

class Exercicio {
  final String imgPath;
  final String nome;
  RxBool? isSelected = false.obs;
  Exercicio({required this.nome, required this.imgPath, this.isSelected});
}
