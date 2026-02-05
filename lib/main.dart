import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iFit/firebase_options.dart';
import 'package:iFit/core/router/app_router.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    // ProviderScope: permite que todo o app use Riverpod
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observa o router provider
    final router = ref.watch(routerProvider as ProviderListenable<dynamic>);

    return MaterialApp.router(
      title: 'iFit',
      debugShowCheckedModeBanner: false,
      
      // Configuração do tema (ajuste conforme seu design)
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      
      // Configuração do go_router
      routerConfig: router,
    );
  }
}

// Placeholder classes (remova depois de ajustar os imports)
class DefaultFirebaseOptions {
  static get currentPlatform => null;
}

class routerProvider {
  static watch(watch) {}
}