import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Criar usuário no Firestore após cadastro
  Future<void> _createUserDocument(User user) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    
    // Verifica se já existe
    final docSnapshot = await userDoc.get();
    if (!docSnapshot.exists) {
      await userDoc.set({
        'email': user.email,
        'nome': user.displayName ?? '',
        'photoUrl': user.photoURL ?? '',
        'createdAt': FieldValue.serverTimestamp(),
        'subscriptionTier': 'free',
      });
    }
  }

  /// Cadastro com Email e Senha
  /// Retorna UserCredential se sucesso, null se falhar
  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Criar documento do usuário no Firestore
      if (userCredential.user != null) {
        await _createUserDocument(userCredential.user!);
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      throw AuthException(message);
    } catch (e) {
      throw AuthException('Erro desconhecido ao cadastrar');
    }
  }

  /// Login com Email e Senha
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      throw AuthException(message);
    } catch (e) {
      throw AuthException('Erro desconhecido ao fazer login');
    }
  }

  /// Login com Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Se o usuário cancelou o login
      if (googleUser == null) {
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential = await _auth.signInWithCredential(credential);

      // Criar documento do usuário no Firestore (se não existir)
      if (userCredential.user != null) {
        await _createUserDocument(userCredential.user!);
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      throw AuthException(message);
    } catch (e) {
      throw AuthException('Erro ao fazer login com Google');
    }
  }

  /// Logout
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw AuthException('Erro ao fazer logout');
    }
  }

  /// Recuperação de senha
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      throw AuthException(message);
    } catch (e) {
      throw AuthException('Erro ao enviar email de recuperação');
    }
  }

  /// Usuário atual
  User? get currentUser => _auth.currentUser;

  /// Stream de mudanças de autenticação
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Mensagens de erro traduzidas
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'A senha é muito fraca';
      case 'email-already-in-use':
        return 'Já existe uma conta com este email';
      case 'user-not-found':
        return 'Nenhum usuário encontrado com este email';
      case 'wrong-password':
        return 'Senha incorreta';
      case 'invalid-email':
        return 'Email inválido';
      case 'user-disabled':
        return 'Esta conta foi desativada';
      case 'too-many-requests':
        return 'Muitas tentativas. Tente novamente mais tarde';
      case 'operation-not-allowed':
        return 'Operação não permitida';
      case 'account-exists-with-different-credential':
        return 'Já existe uma conta com este email usando outro método de login';
      default:
        return 'Erro de autenticação';
    }
  }
}

// Exceção customizada para erros de autenticação
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}