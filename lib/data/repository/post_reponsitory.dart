import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../model/post.dart';

class PostRepository {
  final FirebaseFirestore _firebaseFirestore;

  final FirebaseStorage _firebaseStorage;

  PostRepository(
      {FirebaseStorage? firebaseStorage, FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<List<Post>> getPost() async {
  return _firebaseFirestore.collection("post").get().then((value) =>value.docs.map((e) =>Post.fromJson(e)).toList().reversed.toList());
  }
}
