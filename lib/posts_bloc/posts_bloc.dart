import 'package:tp_firebase_flutter/models/app_exception.dart';
import 'package:tp_firebase_flutter/models/post.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(const PostsState()) {
    on<GetAllPosts>(_onGetAllPosts);
    on<AddPost>(_onAddPost);
    on<RemovePost>(_onRemovePost);
  }

  void _onGetAllPosts(GetAllPosts event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.loading));

    try {
      final posts = await _getAllPosts();
      emit(state.copyWith(
        status: PostsStatus.success,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostsStatus.error,
        error: UnknownException(),
      ));
    }
  }

  void _onAddPost(AddPost event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.addingPost));
    final post = event.post;
    await Future.delayed(const Duration(seconds: 1));

    try {
      emit(state.copyWith(
        status: PostsStatus.addedPostWithSuccess,
        posts: [...state.posts, post],
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: PostsStatus.errorAddingPost,
        error: e,
      ));
    }
  }
/*
  void _onRemovePost(RemovePost event, Emitter<PostsState> emit) {
    emit(PostDeleting());
    final List<Post> updatedPosts = List.from(state.posts)..remove(event.post);
    emit(PostsLoaded(updatedPosts));
  }*/

  void _onRemovePost(RemovePost event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.removingPost));
    final post = event.post;
    await Future.delayed(const Duration(seconds: 1));

    try {
      emit(state.copyWith(
        status: PostsStatus.removedPostWithSuccess,
        posts: List.from(state.posts)..remove(post),
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: PostsStatus.errorRemovingPost,
        error: e,
      ));
    }
  }

  Future<List<Post>> _getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(10, (index) {
      return Post(
        id: index,
        title: 'Post $index',
        description: 'This is the description of post $index',
      );
    });
  }
}
