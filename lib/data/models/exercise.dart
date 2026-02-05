import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Exercise {
  final String imgPath;
  final String name;
  int sets;
  List<int>? repsPerSet;
  List<int>? difficulty;
  List<int>? load;
  List<TextEditingController>? repsControllers;
  List<TextEditingController>? loadControllers;
  int? reps = 10;
  RxBool? isSelected;

  Exercise({
    required this.name,
    required this.imgPath,
    required this.sets,
    this.isSelected,
    this.repsPerSet,
  });

  Object onInitReps() {
    repsPerSet = [];
    for (var i = 0; i < sets; i++) {
      repsPerSet!.add(reps!);
    }
    return reps!;
  }

  Object onInitLoads() {
    load = [];
    for (var i = 0; i < sets; i++) {
      load!.add(0);
    }
    return 0;
  }

  TextEditingController repsController(int index) {
    repsControllers = [];
    for (var i = 0; i < sets; i++) {
      final TextEditingController controller = TextEditingController();

      if (repsPerSet == null) {
        controller.text = this.onInitReps().toString();
      } else {
        controller.text = repsPerSet![index].toString();
      }
      repsControllers!.add(controller);
    }
    return repsControllers![index];
  }

  TextEditingController loadController(int index) {
    loadControllers = [];
    for (var i = 0; i < sets; i++) {
      final TextEditingController controller = TextEditingController();

      if (load == null) {
        controller.text = this.onInitReps().toString();
      } else {
        controller.text = load![index].toString();
      }
      loadControllers!.add(controller);
    }
    return loadControllers![index];
  }

  // Factory melhorado para carregar do Firestore
  factory Exercise.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic>? data = doc.data();

    if (data == null) {
      throw Exception('Dados do exercício inválidos no Firestore.');
    }

    return Exercise(
      name: data['name'] ?? '',
      // AQUI: Se tiver imgUrl no Firestore usa ela, senão usa a imagem mockada
      imgPath: data['imgUrl'] ?? 'assets/images/exercise_placeholder.png',
      sets: data['sets']?.toInt() ?? 3,
    );
  }

  Future<List<Exercise>> fetchExercises(String workoutId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    CollectionReference exercisesCollection = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("workouts")
        .doc(workoutId)
        .collection("exercises");

    QuerySnapshot exercisesSnapshot = await exercisesCollection.get();

    return exercisesSnapshot.docs
        .map((doc) => Exercise.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList();
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'] ?? '',
      imgPath: map['imgUrl'] ?? 'assets/images/exercise_placeholder.png',
      sets: map['sets']?.toInt() ?? 3,
    );
  }

  // Método para converter para Map (útil para salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imgUrl': imgPath,
      'sets': sets,
    };
  }
}