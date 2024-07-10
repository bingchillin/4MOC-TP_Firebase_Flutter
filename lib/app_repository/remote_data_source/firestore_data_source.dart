import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp_firebase_flutter/app_repository/remote_data_source/remote_data_source.dart';

import '../../models/post.dart';

class FirestoreDataSource extends RemoteDataSource {
  @override
  Future<List<Post>> getAllPosts() async {
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

  @override
  Future<Post> addPost(Post post) async {
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

  @override
  Future<void> updatePost(Post post) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(post.id).update({
        'title': post.title,
        'description': post.description,
      });
    } catch (e) {
      throw Exception('Failed to update post: $e');
    }
  }

  @override
  Future<void> removePost(Post post) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(post.id).delete();
    } catch (e) {
      throw Exception('Failed to remove post: $e');
    }
  }
}