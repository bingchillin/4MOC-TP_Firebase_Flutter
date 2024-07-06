import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_firebase_flutter/models/post.dart';
import 'package:tp_firebase_flutter/jsp_bloc/jsp_bloc.dart';

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
        floatingActionButton: BlocBuilder<JspBloc, JspState>(
          builder: (context, state) {
            final removeButtonContent = switch (state.status) {
              JspStatus.removingPost => const CircularProgressIndicator(),
              _ => const Icon(Icons.remove),
            };
            final addButtonContent = switch (state.status) {
              JspStatus.addingPost => const CircularProgressIndicator(),
              _ => const Icon(Icons.add),
            };

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "remove",
                  child: removeButtonContent,
                  onPressed: () => _onRemoveJspTap(context),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: "add",
                  child: addButtonContent,
                  onPressed: () => _onAddJspTap(context),
                ),
              ],
            );
          },
        )
    );
  }

  void _onAddJspTap(BuildContext context) {
    context.read<JspBloc>().add(AddPost(post: post));
  }

  void _onRemoveJspTap(BuildContext context) {
    context.read<JspBloc>().add(RemovePost(post: post));
  }
}
