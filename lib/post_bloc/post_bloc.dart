import 'package:tp_firebase_flutter/models/app_exception.dart';
import 'package:tp_firebase_flutter/models/post.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostsEvent, PostState> {
  PostBloc() : super(const PostState()) {
    on<GetAllPosts>(_onGetAllPosts);
  }

  void _onGetAllPosts(GetAllPosts event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));

    try {
      final posts = await _getAllPosts();
      emit(state.copyWith(
        status: PostStatus.success,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostStatus.error,
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
