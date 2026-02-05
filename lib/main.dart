import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iFit/firebase_options.dart';
import 'package:iFit/presentation/widgets/app_bars/workout_registration_app_bar.dart';
import 'package:iFit/presentation/screens/treino/register_train.dart';
import 'package:iFit/presentation/screens/home.dart';
import 'package:iFit/presentation/screens/auth/login_screen.dart';
import 'package:iFit/presentation/screens/treino/training_screen.dart';
import 'presentation/screens/auth/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/registerWorkout': (context) => const FinishWorkout(),
        '/finishWorkoutRegistration': (context) => const RegisterWorkout(),
        '/workout': (context) => WorkoutScreen()
      },
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}