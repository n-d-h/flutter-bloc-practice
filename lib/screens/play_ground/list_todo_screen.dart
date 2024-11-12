import 'package:bloc_learner/bloc/list_todo/list_todo_bloc.dart';
import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:bloc_learner/widgets/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/todo_model.dart';

class ListToDoScreen extends StatefulWidget {
  const ListToDoScreen({super.key});

  @override
  State<ListToDoScreen> createState() => _ListToDoScreenState();
}

class _ListToDoScreenState extends State<ListToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List todo'),
      ),
      body: BlocBuilder<ListTodoBloc, ListTodoState>(
        builder: (context, state) {
          if (state.todos.isEmpty) {
            return const Center(
              child: Text('No todos'),
            );
          } else {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                return ListTileCustom(
                  index: index,
                  description: state.todos[index].description,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ListTodoBloc>().add(
                AddTodo(
                  todo: Todo(
                    title: 'Todo ${DateTime.now().millisecondsSinceEpoch}',
                    description: 'Todo description',
                  ),
                ),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
