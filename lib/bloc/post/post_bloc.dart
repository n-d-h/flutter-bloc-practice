import 'package:bloc/bloc.dart';
import 'package:bloc_learner/models/post_model.dart';
import 'package:bloc_learner/repositories/post_repository.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepo;

  PostBloc(this.postRepo) : super(const PostState()) {
    on<FetchPost>(_fetchPost);
    _init();
  }

  void _init() {
    add(FetchPost());
  }

  void _fetchPost(FetchPost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));

    try {
      final value = await postRepo.fetchPosts();
      emit(state.copyWith(
        posts: value,
        status: PostStatus.success,
        message: 'success',
      ));
    } catch (error) {
      emit(state.copyWith(
        message: error.toString(),
        status: PostStatus.failure,
      ));
    }
  }
}
