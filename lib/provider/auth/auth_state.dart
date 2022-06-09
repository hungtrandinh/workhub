import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workhub/data/model/my_user.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthState extends Equatable {
  final User? user;
  final AuthStatus authStatus;

  AuthState({this.user, required this.authStatus});

  factory AuthState.UnKnown() {
    return AuthState(authStatus: AuthStatus.unknown);
  }

  AuthState copyWith({
    User? user,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      user: user ?? this.user,
      authStatus: authStatus ?? this.authStatus,
    );
  }

  @override
  List<Object?> get props => [authStatus, user];
}
