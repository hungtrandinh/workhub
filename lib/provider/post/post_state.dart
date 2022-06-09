import 'package:equatable/equatable.dart';

import '../../data/model/post.dart';


enum PostStatus{
  initial,
  success,
  errors
}
class PostState extends Equatable{
  final Post? post;
  final PostStatus postStatus;

  const PostState({
    this.post,
    required this.postStatus
});
  PostState copyWith({
  Post? post,
  PostStatus? postStatus
}){
    return PostState(post: post ?? this.post, postStatus: this.postStatus);
  }
 factory PostState.initial(){
    return const PostState( postStatus:PostStatus.initial);
 }
  @override
  List<Object?> get props => [post,postStatus];

}