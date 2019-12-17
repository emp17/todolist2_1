import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo 2.2'),
        ),
        body: TodoListView(),
      ),
    );
  }
}

class Todo {
  String name;
  String desc;
  bool isDone;

  Todo({
    this.name = '',
    this.desc = '',
    this.isDone = false,
  });
}

class TodoListView extends StatefulWidget {
  TodoListView({
    Key key,
  }) : super(key: key);

  @override
  _TodoListViewState createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  List<Todo> todos = List.generate(
      5,
      (i) => Todo(
            name: i.toString(),
            desc: i.toString(),
            isDone: false,
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: TodoList(
          todos: todos,
          onTog: onTog,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditTodo(),
              ));
        },
      ),
    );
  }

  void onTog(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    return;
  }

  void addTodo() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditTodo(),
        ));
  }
}

typedef OnTogCallback = void Function(Todo);

class TodoList extends StatelessWidget {
  const TodoList({
    Key key,
    this.todos,
    this.onTog,
  }) : super(key: key);
  final List<Todo> todos;
  final onTog;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoTile(
            todo: todos[index],
            index: index,
            onTog: onTog,
          );
        },
      ),
    );
  }
}

class TodoTile extends StatelessWidget {
  const TodoTile({
    Key key,
    this.index,
    this.todo,
    this.onTog,
  }) : super(key: key);
  final Todo todo;
  final int index;
  final OnTogCallback onTog;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.blueGrey,
        child: Container(
          // color: Colors.red,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    onTog(todo);
                  },
                  child: Container(
                    padding: EdgeInsets.all(1),
                    color: Colors.white30,
                    child: Column(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            todo.isDone ? Container() : Text('$index'),
                            Icon(
                              todo.isDone
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              size: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTodo(todo: todo),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(1),
                      color: Colors.white54,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(4),
                            // color: Colors.brown,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  // color: Colors.red,
                                  child: Text(todo.name),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            // color: Colors.green,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  // color: Colors.red,
                                  child: Text(todo.desc),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditTodo extends StatelessWidget {
  const EditTodo({
    Key key,
    this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(todo.name),
          // automaticallyImplyLeading: true,
          // leading: Icon(Icons.arrow_back_ios),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
                initialValue: "${todo.name}",
                onChanged: (text) {
                  todo.name = text;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
                initialValue: "${todo.desc}",
                onChanged: (text) {
                  todo.desc = text;
                },
              ),
            ],
          ),
        ));
  }
}
