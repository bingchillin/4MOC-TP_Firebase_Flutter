part of 'posts_bloc.dart';

enum PostsStatus {
  initial,
  loading,
  success,
  error,
}

class PostsState {
  final PostsStatus status;
  final List<Post> posts;
  final AppException? error;

  const PostsState({
    this.status = PostsStatus.initial,
    this.posts = const [],
    this.error,
  });

  PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
    AppException? error,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error,
    );
  }
}