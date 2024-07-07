import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_firebase_flutter/add_post_screen/add_post_screen.dart';

import 'package:tp_firebase_flutter/jsp_bloc/jsp_bloc.dart';
import 'package:tp_firebase_flutter/posts_bloc/posts_bloc.dart';
import 'package:tp_firebase_flutter/post_detail_screen/post_detail_screen.dart';

import '../models/post.dart';
import 'jsp_screen/jsp_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    _getAllPosts();
  }

  void _getAllPosts() {
    context.read<PostsBloc>().add(GetAllPosts());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostsBloc, PostsState>(
      listener: _onPostsBlocListener,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            final posts = state.posts;

            if (state.status == PostsStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.status == PostsStatus.error) {
              return const Center(
                child: Text("Error loading posts"),
              );
            }

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.description),
                  onTap: () => _onPostTapped(post),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onAddPostTapped(context),
          child: const Icon(Icons.add),
        )
      ),
    );
  }

  void _onPostTapped(Post post) {
    PostDetailScreen.navigateTo(context, post);
  }

  void _onAddPostTapped(BuildContext context) {
    AddPostScreen.navigateTo(context);
  }

  void _onPostsBlocListener(BuildContext context, PostsState state) {
    if (state.status == PostsStatus.errorAddingPost) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            icon: Icon(Icons.error),
            title: Text('Erreur'),
          );
        },
      );
    }
  }
}
