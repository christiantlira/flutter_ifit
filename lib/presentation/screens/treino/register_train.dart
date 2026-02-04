import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iFit/data/models/exercise.dart';
import 'package:iFit/presentation/widgets/app_bars/app_bar.dart';
import 'package:iFit/core/constants/app_colors.dart';
import 'package:iFit/presentation/widgets/tiles/exercise_tile.dart';
import 'package:iFit/presentation/widgets/forms/workout_registration_text_field.dart';
import 'package:iFit/presentation/widgets/forms/text_field.dart';

//Tela de cadastro de treino: Usuário registra os exercicios de cada treino.
class RegisterWorkout extends StatefulWidget {
  const RegisterWorkout({super.key});

  @override
  State<RegisterWorkout> createState() => _RegisterWorkoutState();
}

class _RegisterWorkoutState extends State<RegisterWorkout> {
  late List<Exercise> exercises;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  bool _isInitialized = false; // Flag para evitar múltiplas inicializações

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      exercises = ModalRoute.of(context)!.settings.arguments as List<Exercise>;
      _isInitialized = true; // Marca como inicializado
    }
  }

  void reorderList(int oldIndex, int newIndex) {
    setState(() {
      final Exercise movedItem = exercises.removeAt(oldIndex);
      exercises.insert(
          newIndex > oldIndex ? newIndex - 1 : newIndex, movedItem);
    });
  }

  void updateSets(int index, int newValue) {
    setState(() {
      exercises[index].sets = newValue;
    });
  }

  void registerWorkout() async {
    final user = FirebaseAuth.instance.currentUser; // Obtém usuário logado
    if (user == null) return; // Se não estiver logado, não faz nada

    String workoutName =
        nameController.text; // Você pode pegar isso do TextField

    try {
      // Cria o documento do treino
      DocumentReference workoutRef = FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("workouts")
          .doc(workoutName);

      await workoutRef.set({
        "name": workoutName,
        "imgPath": exercises.first.imgPath,
      });

      // Adiciona os exercícios individualmente
      for (var exercise in exercises) {
        await workoutRef.collection("exercises").add({
          "name": exercise.name,
          "sets": exercise.sets,
          "imgPath": exercise.imgPath,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Workout registered successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error registering workout: $e")),
      );
    }
    Navigator.popAndPushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: MyAppBar(isBack: true, backButtonRoute: '/cadastrarTreino'),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: MyTextField(
                  controller: nameController,
                  label: 'Workout Name',
                  hintText: "'Workout A' or 'Chest Workout'",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Hold and drag to reorder',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ReorderableListView.builder(
                    itemCount: exercises.length,
                    onReorder: reorderList,
                    itemBuilder: (context, index) {
                      return Padding(
                        key: ValueKey(exercises[index]),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ExerciseTileWorkoutRegistration(
                          exercise: exercises[index],
                          textfield: WorkoutRegistrationTextField(
                            exercise: exercises[index],
                            onChanged: (newValue) =>
                                updateSets(index, newValue),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: registerWorkout,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        color: AppColors.primaryRed,
                        borderRadius: BorderRadius.circular(100)),
                    alignment: Alignment.center,
                    child: Text(
                      'Register Workout',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
