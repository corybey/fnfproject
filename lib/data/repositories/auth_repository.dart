import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/firebase_auth_service.dart';
import '../../services/firestore_service.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuthService _auth = FirebaseAuthService.instance;
  final FirestoreService _db = FirestoreService.instance;

  // Stream of auth changes
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  // Currently signed-in user (Firebase User)
  User? get currentUser => _auth.currentUser;

  // Get user profile from Firestore
  Future<UserModel?> getUserProfile(String uid) async {
    final doc = await _db.usersCollection().doc(uid).get();

    if (!doc.exists) return null;
    return UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
  }

  // Create firestore profile for new users
  Future<void> createProfileIfMissing(User user) async {
    final docRef = _db.usersCollection().doc(user.uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      final profile = UserModel(
        uid: user.uid,
        name: user.displayName ?? "",
        email: user.email ?? "",
        joinedGroups: [],
      );

      await docRef.set(profile.toMap());
    }
  }

  // Sign-in using email/password
  Future<UserCredential> signIn(String email, String password) async {
    final cred = await _auth.signIn(email: email, password: password);
    await createProfileIfMissing(cred.user!);
    return cred;
  }

  // Sign out
  Future<void> signOut() => _auth.signOut();
}
