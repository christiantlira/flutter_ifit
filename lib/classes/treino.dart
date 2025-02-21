import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iFit/classes/exercicio.dart';
import 'package:iFit/lists/lists.dart';

class Treino {
  String? id;
  String nome;
  String? imgPath;
  List<Exercicio> exercicios;

  Treino({
    required this.nome,
    this.id,
    required this.exercicios,
    this.imgPath,
  });

  static Future<List<Exercicio>> fetchExercicios(String treinoId) async {
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

  factory Treino.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
      List<Exercicio> exercicios) {
    Map<String, dynamic> data = snapshot.data();

    return Treino(
      id: snapshot.id,
      nome: data['nome'] ?? 'Treino',
      imgPath: data['imgPath'] ?? '',
      exercicios: exercicios,
    );
  }
}
