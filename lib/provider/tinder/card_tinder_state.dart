import 'package:equatable/equatable.dart';
import 'package:workhub/data/model/post.dart';

enum CardStatus1 {
  initial,
  loading,
  success,
  errors
}

class CardState extends Equatable {
  final List<Post>? post;

  final CardStatus1 cardState1;
  const CardState({
    required this.post,
    required this.cardState1,
   
  });
  
  factory CardState.initial(){
    return const CardState(cardState1: CardStatus1.initial ,post:null);
  }
  CardState copyWith({CardStatus1? cardState1,List<Post>? post}){
    return CardState(cardState1: cardState1 ?? this.cardState1, post: post ?? this.post);
  }


  @override
  // TODO: implement props
  List<Object?> get props =>[cardState1,post];


}