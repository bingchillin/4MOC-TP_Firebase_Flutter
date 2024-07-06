part of 'post_bloc.dart';

@immutable
abstract class PostsEvent {}

class GetAllPosts extends PostsEvent {}