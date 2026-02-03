import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iFit/data/models/exercise.dart';

class Workout {
  String? id;
  String name;
  String? imgPath;
  List<Exercise> exercises;

  Workout({
    required this.name,
    this.id,
    required this.exercises,
    this.imgPath,
  });

  static Future<List<Exercise>> fetchExercises(String workoutId) async {
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

  factory Workout.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
      List<Exercise> exercises) {
    Map<String, dynamic> data = snapshot.data();

    return Workout(
      id: snapshot.id,
      name: data['name'] ?? 'Workout',
      imgPath: data['imgPath'] ?? '',
      exercises: exercises,
    );
  }
}
