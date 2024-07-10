import 'package:tp_firebase_flutter/models/app_exception.dart';
import 'package:tp_firebase_flutter/models/post.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../app_repository/app_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final AppRepository appRepository;

  PostsBloc({ required this.appRepository }) : super(const PostsState()) {
    on<GetAllPosts>(_onGetAllPosts);
    on<AddPost>(_onAddPost);
    on<UpdatePost>(_onUpdatePost);
    on<RemovePost>(_onRemovePost);
  }

  void _onGetAllPosts(GetAllPosts event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.loading));

    try {
      final posts = await appRepository.getAllPosts();
      emit(state.copyWith(
        status: PostsStatus.success,
        posts: posts,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: PostsStatus.error,
        error: e,
      ));
    }
  }

  void _onAddPost(AddPost event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.addingPost));

    try {
      Post newPostWithId = await appRepository.addPost(event.post);
      final updatedPosts = List<Post>.from(state.posts)..add(newPostWithId);

      emit(state.copyWith(
        status: PostsStatus.addedPostWithSuccess,
        posts: updatedPosts,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: PostsStatus.errorAddingPost,
        error: e,
      ));
    }
  }

  void _onUpdatePost(UpdatePost event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.updatingPost));

    try {
      await appRepository.updatePost(event.post);

      final updatedPost = state.posts.map((p) {
        return p.id == event.post.id ? event.post : p;
      }).toList();

      emit(state.copyWith(
        status: PostsStatus.updatedPostWithSuccess,
        posts: updatedPost,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: PostsStatus.errorUpdatingPost,
        error: e,
      ));
    }
  }

  void _onRemovePost(RemovePost event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.removingPost));

    try {
      await appRepository.removePost(event.post);

      emit(state.copyWith(
        status: PostsStatus.removedPostWithSuccess,
        posts: List.from(state.posts)..removeWhere((p) => p.id == event.post.id),
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: PostsStatus.errorRemovingPost,
        error: e,
      ));
    }
  }
}
