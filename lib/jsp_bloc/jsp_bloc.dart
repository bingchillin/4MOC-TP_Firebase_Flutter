import 'package:tp_firebase_flutter/models/app_exception.dart';
import 'package:tp_firebase_flutter/models/post.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'jsp_event.dart';
part 'jsp_state.dart';

class JspBloc extends Bloc<JspEvent, JspState> {
  JspBloc() : super(const JspState()) {
    on<AddPost>((_onAddPost));
    on<UpdatePost>((_onUpdatePost));
    on<RemovePost>((_onRemovePost));
  }

  void _onAddPost(AddPost event, Emitter<JspState> emit) async {
    emit(state.copyWith(status: JspStatus.addingPost));
    final post = event.post;
    await Future.delayed(const Duration(seconds: 1));

    try {
      emit(state.copyWith(
        status: JspStatus.addedPostWithSuccess,
        posts: [...state.posts, post],
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: JspStatus.errorAddingPost,
        error: e,
      ));
    }
  }

  void _onUpdatePost(UpdatePost event, Emitter<JspState> emit) async {
    emit(state.copyWith(status: JspStatus.updatingPost));
    final post = event.post;
    await Future.delayed(const Duration(seconds: 1));

    try {
      final updatedPosts = state.posts.map((p) {
        return p.id == post.id ? post : p;
      }).toList();
      emit(state.copyWith(
        status: JspStatus.updatedPostWithSuccess,
        posts: updatedPosts,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: JspStatus.errorUpdatingPost,
        error: e,
      ));
    }
  }

  void _onRemovePost(RemovePost event, Emitter<JspState> emit) async {
    emit(state.copyWith(status: JspStatus.removingPost));
    final post = event.post;
    await Future.delayed(const Duration(seconds: 1));

    try {
      emit(state.copyWith(
        status: JspStatus.removedPostWithSuccess,
        posts: List.from(state.posts)..remove(post),
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: JspStatus.errorRemovingPost,
        error: e,
      ));
    }
  }
}
