import 'package:flutter/foundation.dart';
import 'package:workhub/data/model/custom_error.dart';
import 'package:workhub/data/repository/authen_repository.dart';

import 'signup_state.dart';


class SignUpProvider with ChangeNotifier {
  SignUpState _signUpState = SignUpState.initial();

  SignUpState get state => _signUpState;
  final AuthenticationRepository authenticationRepository;

  SignUpProvider({
    required this.authenticationRepository
  });
  Future<void> signUp({
  required String email,
  required String password
}) async{
    _signUpState = _signUpState.copyWith(signUpStatus: SignUpStatus.submitting);
    notifyListeners();
    try{
      await authenticationRepository.signUp(email: email, password: password);
      _signUpState =_signUpState.copyWith(signUpStatus: SignUpStatus.success);
      notifyListeners();
    }on CustomError catch(e){
      _signUpState =_signUpState.copyWith(
        signUpStatus: SignUpStatus.error,
        customError: e

      );
      notifyListeners();

    }
  }


}