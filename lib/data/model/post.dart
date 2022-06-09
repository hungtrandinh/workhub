import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String image;

  Post({required this.image});

  Post copyWith({String? image}) {
    return Post(image: image ?? this.image);
  }

  factory Post.fromJson(DocumentSnapshot doc) {
    final userData = doc.data() as Map<String, dynamic>;
    return Post(image: userData["image"]);
  }
}
