part of 'post_bloc.dart';

@immutable
abstract class PostEvent {
  const PostEvent();
}

class AddPost extends PostEvent {
  final Post post;

  const AddPost(this.post);
}

class UpdatePost extends PostEvent {
  final Post post;

  const UpdatePost(this.post);
}

class RemovePost extends PostEvent {
  final Post post;

  const RemovePost(this.post);
}