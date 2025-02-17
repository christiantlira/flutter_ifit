import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iFit/firebase_options.dart';
import 'package:iFit/screens/cadastro_treino/cadastroTreino.dart';
import 'package:iFit/screens/cadastro_treino/finalizarTreino.dart';
import 'package:iFit/screens/home.dart';
import 'package:iFit/screens/login/loginTela.dart';
import 'screens/login/loginTela.dart';
import 'screens/registro/registroTela.dart';

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
        '/login': (context) => const LoginTela(),
        '/registro': (context) => const Registrotela(),
        '/home': (context) => const HomeTela(),
        '/cadastrarTreino': (context) => const CadastrarTreino(),
        '/finalizarCadastroTreino' : (context) => const FinalizarCadastroTreino()
      },
      debugShowCheckedModeBanner: false,
      home: const HomeTela(),
    );
  }
}
