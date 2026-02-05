import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// IMPORTANTE: Ajuste o import pro caminho correto do seu projeto
// import 'package:iFit/data/services/auth_service.dart';

// Provider do AuthService (singleton)
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Provider que escuta mudanças no estado de autenticação do Firebase
final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

// Provider que retorna o usuário atual (ou null se não estiver logado)
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) => user,
    loading: () => null,
    error: (_, __) => null,
  );
});

// Provider que retorna se o usuário está logado
final isAuthenticatedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
});

// Classe AuthService (coloque isso num arquivo separado depois)
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  // Métodos de auth aqui (vou detalhar depois)
}