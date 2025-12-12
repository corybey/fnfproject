//authorization controller

import 'package:flutter/foundation.dart';
import '../data/models/user_model.dart';
import '../data/repositories/auth_repository.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository _repo;

  UserModel? currentUser;
  bool isLoading = false;

  AuthController(this._repo);
//load user and sign out
  Future<void> loadCurrentUser() async {
    isLoading = true;
    notifyListeners();

    currentUser = await _repo.getCurrentUserProfile();

    isLoading = false;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    isLoading = true;
    notifyListeners();

    await _repo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    await loadCurrentUser();
  }

  Future<void> signOut() async {
    await _repo.signOut();
    currentUser = null;
    notifyListeners();
  }
}
