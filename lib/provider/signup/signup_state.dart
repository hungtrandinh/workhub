import 'package:equatable/equatable.dart';
import 'package:workhub/data/model/custom_error.dart';

enum SignUpStatus { initial, submitting, success, error }

class SignUpState extends Equatable {
  final SignUpStatus signUpStatus;

  final CustomError customError;

  SignUpState({required this.customError, required this.signUpStatus});

  factory SignUpState.initial() {
    return SignUpState(
        customError: const CustomError(), signUpStatus: SignUpStatus.initial);
  }

  SignUpState copyWith({
    SignUpStatus? signUpStatus,
    CustomError? customError,
  }) {
    return SignUpState(
        customError: customError ?? this.customError,
        signUpStatus: signUpStatus ?? this.signUpStatus);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [signUpStatus,customError];
}
