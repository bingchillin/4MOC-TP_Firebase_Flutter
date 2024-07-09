import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_firebase_flutter/add_post_screen/add_post_screen.dart';
import 'package:tp_firebase_flutter/post_detail_screen/post_detail_screen.dart';
import 'package:tp_firebase_flutter/posts_bloc/posts_bloc.dart';
import 'package:tp_firebase_flutter/posts_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'jsp_bloc/jsp_bloc.dart';
import 'jsp_screen/jsp_screen.dart';
import 'models/post.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(MyApp());
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
            AddPostScreen.routeName: (context) => const AddPostScreen(),
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
