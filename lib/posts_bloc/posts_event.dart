part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {
  const PostsEvent();
}

class GetAllPosts extends PostsEvent {}

class AddPost extends PostsEvent {
  final Post post;

  const AddPost({required this.post});
}

class UpdatePost extends PostsEvent {
  final Post post;

  const UpdatePost({required this.post});
}

class RemovePost extends PostsEvent {
  final Post post;

  const RemovePost({required this.post});
}