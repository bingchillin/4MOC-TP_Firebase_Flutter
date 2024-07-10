import 'package:tp_firebase_flutter/models/app_exception.dart';
import 'package:tp_firebase_flutter/models/post.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(const PostsState()) {
    on<GetAllPosts>(_onGetAllPosts);
    on<AddPost>(_onAddPost);
    on<UpdatePost>(_onUpdatePost);
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
      Post newPostWithId = await _addPost(event.post);
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
      await _updatePost(event.post);

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
      await _removePost(event.post);

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

  Future<List<Post>> _getAllPosts() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('posts').get();
      final posts = querySnapshot.docs.map((doc) {
        return Post(
          id: doc.id,
          title: doc.data()['title'] as String,
          description: doc.data()['description'] as String,
        );
      }).toList();
      return posts;
    } catch (e) {
      throw Exception('Error fetching posts : $e');
    }
  }

  Future<Post> _addPost(Post post) async {
    try {
      DocumentReference docRef = await FirebaseFirestore.instance.collection('posts').add({
        'title': post.title,
        'description': post.description,
      });
      return Post(id: docRef.id, title: post.title, description: post.description);
    } catch (e) {
      throw Exception( 'Failed to add post: $e');
    }
  }

  Future<void> _updatePost(Post post) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(post.id).update({
        'title': post.title,
        'description': post.description,
      });
    } catch (e) {
      throw Exception('Failed to update post: $e');
    }
  }

  Future<void> _removePost(Post post) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(post.id).delete();
    } catch (e) {
      throw Exception('Failed to remove post: $e');
    }
  }
}
