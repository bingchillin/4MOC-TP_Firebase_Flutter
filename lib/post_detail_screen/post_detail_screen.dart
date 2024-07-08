import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_firebase_flutter/models/post.dart';
import 'package:tp_firebase_flutter/posts_bloc/posts_bloc.dart';

class PostDetailScreen extends StatefulWidget {
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
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _descriptionController = TextEditingController(text: widget.post.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _onUpdateTap(context),
              child: const Text('Modifier'),
            ),
            ElevatedButton(
              onPressed: () => _onRemoveTap(context),
              child: const Text('Supprimer'),
            ),
          ],
        ),
      ),
    );
  }

  void _onUpdateTap(BuildContext context) {
    final updatedPost = Post(
      id: widget.post.id,
      title: _titleController.text,
      description: _descriptionController.text,
    );

    context.read<PostsBloc>().add(UpdatePost(post: updatedPost));
    Navigator.of(context).pop();
  }

  void _onRemoveTap(BuildContext context) {
    context.read<PostsBloc>().add(RemovePost(post: widget.post));
    Navigator.of(context).pop();
  }
}
