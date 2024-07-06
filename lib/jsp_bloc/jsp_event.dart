part of 'jsp_bloc.dart';

@immutable
abstract class JspEvent {
  const JspEvent();
}

class AddPost extends JspEvent {
  final Post post;

  const AddPost(this.post);
}

class UpdatePost extends JspEvent {
  final Post post;

  const UpdatePost(this.post);
}

class RemovePost extends JspEvent {
  final Post post;

  const RemovePost(this.post);
}