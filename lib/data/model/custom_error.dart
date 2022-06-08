import 'package:equatable/equatable.dart';

class CustomError extends Equatable{
  final String? code ;
  final String? massage ;
  final String? plugin ;
  const CustomError({
   this.code ="",
   this.massage="",
   this.plugin=""
});

  @override
  List<Object?> get props => [code,massage,plugin];

  @override
  bool get stringify => true;
}