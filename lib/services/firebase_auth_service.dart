import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuthService._internal();
  static final FirebaseAuthService instance = FirebaseAuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  // Listen for auth state changes
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  // Current signed-in Firebase user
  User? get currentUser => _auth.currentUser;

  // Email/password sign-in
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign out user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
