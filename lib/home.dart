import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/bloc/todo/todo_bloc.dart';
import 'package:todo/data/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  addTodo(Todo todo) {
    context.read<TodoBloc>().add(
          AddTodo(todo: todo),
        );
  }

  removeTodo(Todo todo) {
    context.read<TodoBloc>().add(
          RemoveTodo(todo: todo),
        );
  }

  alertTodo(int index) {
    context.read<TodoBloc>().add(AlterTodo(index: index));
  }

  editTodo(Todo todo, int index) {
    context.read<TodoBloc>().add(EditTodo(todo: todo, index: index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  TextEditingController titleController =
                      TextEditingController();
                  TextEditingController subTitleController =
                      TextEditingController();

                  return AlertDialog(
                    title: const Text('Buat Tugas Baru'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Judul Tugas...',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.greenAccent),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: subTitleController,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Deskripsi Tugas...',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.greenAccent),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                            onPressed: () {
                              addTodo(
                                Todo(
                                    title: titleController.text,
                                    subTitle: subTitleController.text),
                              );
                              titleController.text = '';
                              subTitleController.text = '';
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.black,
                                ))),
                      )
                    ],
                  );
                });
          },
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: const Text('Todo App'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state.status == TodoStatus.success) {
                return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, int i) {
                      return Card(
                          color: Colors.greenAccent,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Slidable(
                            key: const ValueKey(0),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) {
                                    removeTodo(state.todos[i]);
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                                SlidableAction(
                                  onPressed: (_) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          TextEditingController
                                              titleController =
                                              TextEditingController(text: state.todos[i].title);
                                          TextEditingController
                                              subTitleController =
                                              TextEditingController(text: state.todos[i].subTitle);

                                          return AlertDialog(
                                            title:
                                                const Text('Edit Tugas'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller: titleController,
                                                  cursorColor: Colors.white,
                                                  decoration: InputDecoration(
                                                    hintText: 'Judul Tugas...',
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .greenAccent),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                TextField(
                                                  controller:
                                                      subTitleController,
                                                  cursorColor: Colors.white,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Deskripsi Tugas...',
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .greenAccent),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: TextButton(
                                                    onPressed: () {
                                                      editTodo(
                                                        Todo(
                                                            title:
                                                                titleController
                                                                    .text,
                                                            subTitle:
                                                                subTitleController
                                                                    .text),i
                                                      );
                                                      titleController.text = '';
                                                      subTitleController.text =
                                                          '';
                                                      Navigator.pop(context);
                                                    },
                                                    style: TextButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                          color: Colors.black,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      foregroundColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .secondary,
                                                    ),
                                                    child: SizedBox(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: const Icon(
                                                          Icons.check,
                                                          color: Colors.black,
                                                        ))),
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  backgroundColor: Colors.yellow,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                              ],
                            ),
                            child: ListTile(
                                title: Text(state.todos[i].title),
                                subtitle: Text(state.todos[i].subTitle),
                                trailing: Checkbox(
                                    value: state.todos[i].isDone,
                                    activeColor: Colors.greenAccent,
                                    onChanged: (value) {
                                      alertTodo(i);
                                    })),
                          ));
                    });
              } else if (state.status == TodoStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
