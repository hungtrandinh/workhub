import 'package:firebase_auth/firebase_auth.dart'as auth;
import 'package:flutter/cupertino.dart';
import 'package:workhub/data/repository/authen_repository.dart';

import 'auth_state.dart';

class AuthProvider with ChangeNotifier {

  AuthState _state = AuthState.UnKnown();

  AuthState get state => _state;

  final AuthenticationRepository authenticationRepository;

  AuthProvider({

    required this.authenticationRepository
  });

  void update(auth.User? user) {
    if (user != null) {
      _state = _state.copyWith(
        authStatus: AuthStatus.authenticated,
      );
    } else {
      _state = _state.copyWith(authStatus: AuthStatus.unauthenticated);
    }
    notifyListeners();
  }


  void signOut() async {
    await authenticationRepository.logOut();
  }
}