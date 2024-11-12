import 'package:bloc/bloc.dart';
import 'package:bloc_learner/models/todo_model.dart';
import 'package:equatable/equatable.dart';

part 'list_todo_event.dart';

part 'list_todo_state.dart';

class ListTodoBloc extends Bloc<ListTodoEvent, ListTodoState> {
  ListTodoBloc() : super(const ListTodoState()) {
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  void _onAddTodo(AddTodo event, Emitter<ListTodoState> emit) {
    final List<Todo> updatedTodos = List<Todo>.from(state.todos)
      ..add(event.todo);
    emit(state.copyWith(todos: updatedTodos));
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<ListTodoState> emit) {
    final List<Todo> updatedTodos = List<Todo>.from(state.todos)
      ..[event.index] = event.todo;
    emit(state.copyWith(todos: updatedTodos));
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<ListTodoState> emit) {
    final List<Todo> updatedTodos = List<Todo>.from(state.todos)
      ..removeAt(event.index);
    emit(state.copyWith(todos: updatedTodos));
  }
}
