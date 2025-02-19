import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Exercicio {
  final String imgPath;
  final String nome;
  int? series = 3;

  int? index;
  RxBool? isSelected = false.obs;

  Exercicio({
    required this.nome,
    required this.imgPath,
    this.isSelected,
    this.series,
  });

// Método para criar um exercício a partir de um documento do Firestore
  factory Exercicio.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Exercicio(
      nome: data['nome'],
      imgPath: data['imgPath'],
      series: data['series'],
    );
  }

  factory Exercicio.fromMap(Map<String, dynamic> map) {
    return Exercicio(
      nome: map['nome'],
      series: map['series'],
      imgPath: map['imgPath'],
    );
  }
}
