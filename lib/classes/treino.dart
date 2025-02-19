import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:iFit/classes/exercicio.dart';

class Treino {
  String? id;
  String nome;
  String? imgPath;
  List<Exercicio> exercicios;

  Treino({required this.nome, this.id, required this.exercicios});

  // Método para criar um treino a partir de um documento do Firestore
  factory Treino.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Treino(
      id: doc.id, // Armazena o ID do documento
      nome: data['nome'],
      exercicios: data[
          'exercicios'], // Inicializa a lista de exercícios, que será preenchida depois
    );
  }
}
