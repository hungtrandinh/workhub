import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String image;

  Post({required this.image});

  Post copyWith({String? image}) {
    return Post(image: image ?? this.image);
  }


  factory Post.fromJson(DocumentSnapshot doc) {
    final userData = doc.data() as Map<String, dynamic>;
    return Post(image: userData["image"]);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [image];
}
