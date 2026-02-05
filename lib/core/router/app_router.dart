import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// IMPORTANTE: Ajuste os imports para os caminhos corretos do seu projeto
// import 'package:iFit/presentation/screens/auth/login_screen.dart';
// import 'package:iFit/presentation/screens/auth/register_screen.dart';
// import 'package:iFit/presentation/screens/home.dart';
// import 'package:iFit/presentation/screens/treino/register_train.dart';
// import 'package:iFit/presentation/screens/treino/training_screen.dart';
// import 'package:iFit/providers/auth_provider.dart';

// Provider do router
final routerProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(isAuthenticatedProvider);
  
  return GoRouter(
    initialLocation: '/login',
    
    // Redirect logic: protege rotas que precisam de autenticação
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';
      final isRegistering = state.matchedLocation == '/register';
      
      // Se não está logado e não está indo pra login/registro, redireciona pro login
      if (!isAuthenticated && !isLoggingIn && !isRegistering) {
        return '/login';
      }
      
      // Se está logado e tentando acessar login/registro, redireciona pra home
      if (isAuthenticated && (isLoggingIn || isRegistering)) {
        return '/home';
      }
      
      // Caso contrário, permite navegar
      return null;
    },
    
    routes: [
      // ========== ROTAS PÚBLICAS (não precisa estar logado) ==========
      
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      
      // ========== ROTAS PROTEGIDAS (precisa estar logado) ==========
      
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      
      GoRoute(
        path: '/register-workout',
        name: 'registerWorkout',
        builder: (context, state) => const FinishWorkout(),
      ),
      
      GoRoute(
        path: '/finish-workout-registration',
        name: 'finishWorkoutRegistration',
        builder: (context, state) => const RegisterWorkout(),
      ),
      
      GoRoute(
        path: '/workout/:id',
        name: 'workout',
        builder: (context, state) {
          final workoutId = state.pathParameters['id'];
          return WorkoutScreen(workoutId: workoutId);
        },
      ),
    ],
    
    // Tratamento de erros (404, etc)
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Página não encontrada',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go('/home'),
              child: const Text('Voltar para Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

// Placeholder classes (você vai substituir pelos seus imports reais)
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class FinishWorkout extends StatelessWidget {
  const FinishWorkout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class RegisterWorkout extends StatelessWidget {
  const RegisterWorkout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class WorkoutScreen extends StatelessWidget {
  final String? workoutId;
  const WorkoutScreen({Key? key, this.workoutId}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Placeholder();
}

// Provider para facilitar acesso ao isAuthenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  // Temporário - você vai substituir pelo import real
  return false;
});