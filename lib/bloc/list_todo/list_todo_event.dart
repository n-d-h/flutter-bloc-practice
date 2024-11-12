part of 'list_todo_bloc.dart';

abstract class ListTodoEvent {
  const ListTodoEvent();
}

class AddTodo extends ListTodoEvent {
  final Todo todo;
  const AddTodo({required this.todo});

  List<Object> get props => [todo];
}

class UpdateTodo extends ListTodoEvent {
  final int index;
  final Todo todo;
  const UpdateTodo({required this.index, required this.todo});

  List<Object> get props => [index, todo];
}

class DeleteTodo extends ListTodoEvent {
  final int index;
  const DeleteTodo({required this.index});

  List<Object> get props => [index];
}
