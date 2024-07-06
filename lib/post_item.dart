import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_firebase_flutter/jsp_bloc/jsp_bloc.dart';
import '../models/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key,
    required this.post,
    this.onTap
  });

  final Post post;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.description),
      trailing: BlocBuilder<JspBloc, JspState>(
        buildWhen: (previousState, nextState) {
          final hasJspChanged = previousState.posts.length != nextState.posts.length;
          final previousOccurences = previousState.posts.where((element) => element.id == post.id).length;
          final nextOccurences = nextState.posts.where((element) => element.id == post.id).length;

          if(!hasJspChanged) {
            return false;
          }
          if(previousOccurences == nextOccurences) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          print('Building ${post.id} post');
          final occurences = state.posts.where((element) => element.id == post.id).length;
          if(occurences == 0) {
            return const SizedBox();
          }
          return Text('$occurences dans jsp');
        }
      ),
      onTap: onTap,
    );
  }
}