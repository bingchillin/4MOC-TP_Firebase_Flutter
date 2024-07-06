import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'jsp_bloc/jsp_bloc.dart';
import 'post_bloc/post_bloc.dart';

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
            create: (context) => PostBloc(),
          ),
          BlocProvider(
            create: (context) => JspBloc(),
          ),
        ],
        child: MaterialApp(
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}
