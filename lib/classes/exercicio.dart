import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Exercicio {
  final String imgPath;
  final String nome;
  int series;
  int? reps = 8;
  RxBool? isSelected;

  Exercicio(
      {required this.nome,
      required this.imgPath,
      required this.series, // Agora é requerido
      this.isSelected});

  // Método para criar um exercício a partir de um documento do Firestore
  factory Exercicio.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic>? data =
        doc.data(); // Pode ser null se o documento estiver vazio

    if (data == null) {
      throw Exception(
          'Dados do exercício inválidos no Firestore.'); // Lança uma exceção para melhor tratamento de erro
    }

    return Exercicio(
      nome: data['nome'] ??
          '', // Usando ?? para valores padrão se não existir no Firestore.
      imgPath: data['imgPath'] ??
          '', // Usando ?? para valores padrão se não existir no Firestore.
      series: data['series']?.toInt() ??
          3, // Usando ?? para valor padrão 3 e convertendo para inteiro.
    );
  }

  Future<List<Exercicio>> fetchExercicios(String treinoId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    CollectionReference exerciciosCollection = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("treinos")
        .doc(treinoId)
        .collection("exercicios");

    QuerySnapshot exerciciosSnapshot = await exerciciosCollection.get();

    return exerciciosSnapshot.docs
        .map((doc) => Exercicio.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList();
  }

  factory Exercicio.fromMap(Map<String, dynamic> map) {
    return Exercicio(
      nome: map['nome'] ?? '',
      imgPath: map['imgPath'] ?? '',
      series: map['series']?.toInt() ?? 3,
    );
  }
}
