import 'package:equatable/equatable.dart';
import 'package:workhub/data/model/custom_error.dart';

enum SignInStatus{
  initial,
  submitting,
  success,
  error,
}
class SignInState extends Equatable{
  final SignInStatus signInStatus;
  final CustomError customError;
  SignInState({
    required this.customError,
    required this.signInStatus
});
  factory SignInState.initial(){
    return SignInState(customError: const CustomError(), signInStatus: SignInStatus.initial);
  }
  SignInState copyWith({
    SignInStatus? signInStatus,
    CustomError? customError,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      customError: customError ?? this.customError,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props =>[signInStatus,customError];
}