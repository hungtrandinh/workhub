import 'package:flutter/material.dart';
import 'package:workhub/provider/post/post_state.dart';

import '../../data/repository/post_reponsitory.dart';



class PostProvider with ChangeNotifier{
  PostState postState = PostState.initial();
 final PostRepository postRepository;
  PostProvider({
    required this.postRepository
});

}