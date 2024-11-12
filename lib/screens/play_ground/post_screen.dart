import 'package:bloc_learner/bloc/post/post_bloc.dart';
import 'package:bloc_learner/widgets/custom_animations/loading/loading_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

// in this post screen we will fetch posts


class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Screen'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.loading:
              return const LoadingBox();
            case PostStatus.success:
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      child: ListTile(
                        title: Text(post.email ?? ''),
                        subtitle: Text(post.name ?? ''),
                      ),
                    ),
                  );
                },
              );
            case PostStatus.failure:
              return Center(
                child: Text(state.message),
              );
          }
        },
      ),
    );
  }
}
