import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String? id;
  final String title;
  final String description;

  const Post({
    this.id,
    required this.title,
    required this.description,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  @override
  List<Object> get props => [id ?? '', title, description];
}