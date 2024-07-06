import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_firebase_flutter/jsp_bloc/jsp_bloc.dart';
import 'package:tp_firebase_flutter/post_item.dart';

class JspScreen extends StatelessWidget {
  static const routeName = 'jspScreen';

  static Future<void> navigateTo(BuildContext context) {
    return Navigator.of(context).pushNamed(routeName);
  }

  const JspScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSP'),
      ),
      body: BlocBuilder<JspBloc, JspState>(
        builder: (context, state) {
          final posts = state.posts.toSet();

          return ListView.separated(
            itemCount: posts.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final post = posts.elementAt(index);
              return PostItem(post: post);
            },
          );
        },
      ),
    );
  }
}
