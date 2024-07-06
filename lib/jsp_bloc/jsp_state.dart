part of 'jsp_bloc.dart';

enum JspStatus {
  initial,

  addingPost,
  addedPostWithSuccess,
  errorAddingPost,

  updatingPost,
  updatedPostWithSuccess,
  errorUpdatingPost,

  removingPost,
  removedPostWithSuccess,
  errorRemovingPost,
}

class JspState {
  final JspStatus status;
  final List<Post> posts;
  final AppException? error;

  const JspState({
    this.status = JspStatus.initial,
    this.posts = const [],
    this.error,
  });

  JspState copyWith({
    JspStatus? status,
    List<Post>? posts,
    AppException? error,
  }) {
    return JspState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error,
    );
  }
}