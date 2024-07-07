import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_firebase_flutter/models/post.dart';
import 'package:tp_firebase_flutter/posts_bloc/posts_bloc.dart';

class PostDetailScreen extends StatelessWidget {
  static const routeName = 'postDetailScreen';

  static Future<void> navigateTo(BuildContext context, Post post) {
    return Navigator.of(context).pushNamed(routeName, arguments: post);
  }

  const PostDetailScreen({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Logique pour modifier (à implémenter)
              },
              child: Text('Modifier'),
            ),
            ElevatedButton(
              onPressed: () => _onRemoveTap(context),
              child: Text('Supprimer'),
            ),
          ],
        ),
      ),
    );
  }

  void _onRemoveTap(BuildContext context) {
    context.read<PostsBloc>().add(RemovePost(post: post));
    Navigator.of(context).pop();
  }
}
