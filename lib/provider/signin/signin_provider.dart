import 'package:flutter/material.dart';
import 'package:workhub/data/repository/authen_repository.dart';
import 'package:workhub/provider/signin/signin_state.dart';

import '../../data/model/custom_error.dart';

class SignInProvider extends ChangeNotifier{
  SignInState _state = SignInState.initial();
  SignInState get state => _state;

  final AuthenticationRepository authenticationRepository;
  SignInProvider({
    required this.authenticationRepository ,
  });

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _state = _state.copyWith(signInStatus: SignInStatus.submitting);
    notifyListeners();

    try {
      await authenticationRepository.logInWithEmailAndPassword(email: email, password: password);
      _state = _state.copyWith(signInStatus: SignInStatus.success);
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(
        signInStatus: SignInStatus.error,
        customError: e,
      );
      notifyListeners();
      rethrow;
    }
  }
}