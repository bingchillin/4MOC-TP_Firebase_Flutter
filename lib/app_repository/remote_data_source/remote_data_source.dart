import 'package:tp_firebase_flutter/models/post.dart';

abstract class RemoteDataSource {
  Future<List<Post>> getAllPosts();
  Future<Post> addPost(Post post);
  Future<void> updatePost(Post post);
  Future<void> removePost(Post post);
}