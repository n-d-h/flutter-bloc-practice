part of 'post_bloc.dart';

enum PostStatus { loading, success, failure }

class PostState extends Equatable {
  final List<PostModel> posts;
  final PostStatus status;
  final String message;

  const PostState({
    this.posts = const <PostModel>[],
    this.status = PostStatus.loading,
    this.message = '',
  });

  PostState copyWith({
    List<PostModel>? posts,
    PostStatus? status,
    String? message,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [posts, status, message];
}
