import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_firebase_flutter/post_detail_screen/post_detail_screen.dart';
import 'package:tp_firebase_flutter/posts_bloc/posts_bloc.dart';
import 'package:tp_firebase_flutter/posts_screen.dart';

import 'jsp_bloc/jsp_bloc.dart';
import 'jsp_screen/jsp_screen.dart';
import 'models/post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostsBloc(),
          ),
          BlocProvider(
            create: (context) => JspBloc(),
          ),
        ],
        child: MaterialApp(
          home: const PostsScreen(),
          routes: {
            JspScreen.routeName: (context) => const JspScreen(),
          },
          onGenerateRoute: (settings) {
            Widget content = const SizedBox();

            switch(settings.name) {
              case PostDetailScreen.routeName:
                final arguments = settings.arguments;
                if(arguments is Post) {
                  content = PostDetailScreen(post: arguments);
                }
                break;
            }

            return MaterialPageRoute(
              builder: (context) => content,
            );
          },
        ));
  }
}
