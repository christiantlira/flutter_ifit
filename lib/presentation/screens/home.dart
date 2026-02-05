import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iFit/data/models/exercise.dart';
import 'package:iFit/data/models/train.dart'; // Certifique-se que Workout.fromFirestore está correto
import 'package:iFit/presentation/widgets/app_bars/bottom_app_bar.dart';
import 'package:iFit/core/constants/app_colors.dart';
import 'package:iFit/presentation/widgets/app_bars/app_bar.dart';
import 'package:iFit/presentation/carousels/workouts_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Workout>> futureWorkouts;

  @override
  void initState() {
    super.initState();
    futureWorkouts = fetchWorkouts();
  }

  Future<List<Workout>> fetchWorkouts() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return []; // Se não houver usuário, retorna lista vazia
    }

    try {
      CollectionReference workoutsCollection = FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("workouts");

      QuerySnapshot workoutsSnapshot = await workoutsCollection.get();

      List<Workout> workouts = await Future.wait(
        workoutsSnapshot.docs.map((doc) async {
          List<Exercise> exercises = await Workout.fetchExercises(doc.id);
          return Workout.fromFirestore(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>, exercises);
        }),
      );
      return workouts;
    } catch (e) {
      print("Error fetching workouts: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: MyAppBar(
          backButtonRoute: '/login',
          isBack: true,
        ),
        body: FutureBuilder<List<Workout>>(
          future: futureWorkouts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error loading workouts: ${snapshot.error}",
                    style: const TextStyle(color: Colors.white)),
              );
            } else {
              List<Workout> workouts = snapshot.data ?? [];
              return MyWorkoutCarousel(workouts: workouts);
            }
          },
        ),
        bottomNavigationBar: MyBottomAppBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryRed,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/registerWorkout');
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
