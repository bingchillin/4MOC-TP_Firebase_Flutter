part of 'post_bloc.dart';

enum PostStatus {
  initial,
  loading,
  success,
  error,
}

class PostState {
  final PostStatus status;
  final List<Post> posts;
  final AppException? error;

  const PostState({
    this.status = PostStatus.initial,
    this.posts = const [],
    this.error,
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    AppException? error,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error,
    );
  }
}