import 'package:tp_firebase_flutter/models/app_exception.dart';
import 'package:tp_firebase_flutter/models/post.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState()) {
    on<AddPost>((_onAddPost));
    on<UpdatePost>((_onUpdatePost));
    on<RemovePost>((_onRemovePost));
  }

  void _onAddPost(AddPost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.addingPost));
    final post = event.post;
    await Future.delayed(const Duration(seconds: 1));

    try {
      emit(state.copyWith(
        status: PostStatus.addedPostWithSuccess,
        posts: [...state.posts, post],
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: PostStatus.errorAddingPost,
        error: e,
      ));
    }
  }

  void _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.updatingPost));
    final post = event.post;
    await Future.delayed(const Duration(seconds: 1));

    try {
      final updatedPosts = state.posts.map((p) {
        return p.id == post.id ? post : p;
      }).toList();
      emit(state.copyWith(
        status: PostStatus.updatedPostWithSuccess,
        posts: updatedPosts,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: PostStatus.errorUpdatingPost,
        error: e,
      ));
    }
  }

  void _onRemovePost(RemovePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.removingPost));
    final post = event.post;
    await Future.delayed(const Duration(seconds: 1));

    try {
      emit(state.copyWith(
        status: PostStatus.removedPostWithSuccess,
        posts: List.from(state.posts)..remove(post),
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: PostStatus.errorRemovingPost,
        error: e,
      ));
    }
  }
}
