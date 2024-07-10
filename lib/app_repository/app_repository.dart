import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp_firebase_flutter/app_repository/remote_data_source/remote_data_source.dart';
import 'package:tp_firebase_flutter/models/post.dart';

class AppRepository {
  final RemoteDataSource remoteDataSource;
  //final LocalDataSource localDataSource;

  AppRepository({
    required this.remoteDataSource,
    //required this.localDataSource,
  });

  Future<List<Post>> getAllPosts() async {
    return remoteDataSource.getAllPosts();
  }

  Future<Post> addPost(Post post) async {
    return remoteDataSource.addPost(post);
  }

  Future<void> updatePost(Post post) async {
    return remoteDataSource.updatePost(post);
  }

  Future<void> removePost(Post post) async {
    return remoteDataSource.removePost(post);
  }
}