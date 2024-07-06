import 'package:tp_firebase_flutter/models/app_exception.dart';
import 'package:tp_firebase_flutter/models/post.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(const PostsState()) {
    on<GetAllPosts>(_onGetAllPosts);
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
