part of 'list_todo_bloc.dart';

class ListTodoState extends Equatable{
  final List<Todo> todos;
  const ListTodoState({this.todos = const []});

  ListTodoState copyWith({List<Todo>? todos}) {
    return ListTodoState(todos: todos ?? this.todos);
  }

  @override
  List<Object> get props => [todos];
}


