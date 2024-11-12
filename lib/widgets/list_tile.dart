import 'package:bloc_learner/bloc/list_todo/list_todo_bloc.dart';
import 'package:bloc_learner/models/todo_model.dart';
import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListTileCustom extends StatefulWidget {
  final int index;
  final String description;

  const ListTileCustom(
      {super.key, required this.index, required this.description});

  @override
  State<ListTileCustom> createState() => _ListTileCustomState();
}

class _ListTileCustomState extends State<ListTileCustom> {
  bool _enabled = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _enabled = true;
        });
      },
      child: ListTile(
        titleTextStyle: TextStyle(
            color: DarkMode.getForegroundColor(context).withOpacity(0.5)),
        subtitleTextStyle:
            TextStyle(color: DarkMode.getForegroundColor(context)),
        title: Text('Todo ${widget.index + 1}'),
        subtitle: !_enabled
            ? Text(widget.description)
            : TextField(
                autofocus: true,
                enabled: _enabled,
                controller: _controller,
                style: TextStyle(color: DarkMode.getForegroundColor(context)),
                decoration: const InputDecoration(
                  hintText: 'Enter a text',
                ),
              ),
        trailing: IconButton(
          icon: _enabled
              ? const Icon(Icons.check, color: Colors.green)
              : Icon(Icons.delete, color: Colors.red.shade800),
          onPressed: () {
            if (_enabled) {
              setState(() {
                _enabled = false;
                context.read<ListTodoBloc>().add(UpdateTodo(
                      index: widget.index,
                      todo: Todo(
                        title: 'Todo ${widget.index}',
                        description: _controller.text,
                      ),
                    ));
              });
            } else {
              setState(() {
                _enabled = false;
                context
                    .read<ListTodoBloc>()
                    .add(DeleteTodo(index: widget.index));
              });
            }
          },
        ),
      ),
    );
  }
}
