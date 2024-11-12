import 'package:bloc_learner/bloc/calculator/calculator_bloc.dart';
import 'package:bloc_learner/bloc/favorite_app/favorite_app_bloc.dart';
import 'package:bloc_learner/bloc/image_picker/image_picker_bloc.dart';
import 'package:bloc_learner/bloc/post/post_bloc.dart';
import 'package:bloc_learner/repositories/post_repository.dart';
import 'package:bloc_learner/utils/image_picker_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter/counter_bloc.dart';
import 'bloc/list_todo/list_todo_bloc.dart';
import 'bloc/switch/switch_bloc.dart';

class Blocs {
  static final blocProviders = [
    BlocProvider<CounterBloc>(create: (_) => CounterBloc()),
    BlocProvider<SwitchBloc>(create: (_) => SwitchBloc()),
    BlocProvider<ImagePickerBloc>(create: (_) => ImagePickerBloc(ImagePickerUtils())),
    BlocProvider<ListTodoBloc>(create: (_) => ListTodoBloc()),
    BlocProvider<FavoriteAppBloc>(create: (_) => FavoriteAppBloc()),
    BlocProvider<PostBloc>(create: (_) => PostBloc(PostRepository())),
    BlocProvider<CalculatorBloc>(create: (_) => CalculatorBloc()),
  ];
}