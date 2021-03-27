import 'package:flutter/material.dart';
import 'package:to_do_app/helpers/drawer_navigation.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/screens/todo_screen.dart';
import 'package:to_do_app/services/todo_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoService _todoService;
  List<Todo> _todoList = List<Todo>.empty(growable: true);

  @override
  void initState(){
    super.initState();
    getAllTodos();
  }

  getAllTodos() async{
    _todoService = TodoService();
    //_todoList = List<Todo>.empty(growable: true);
    var todos = await _todoService.getTodos();
    todos.forEach(
        (todo){
          setState(() {
            var model = Todo();
            model.id = todo["id"];
            model.title = todo["title"];
            model.description = todo["description"];
            model.category = todo["category"];
            model.todoDate = todo["todoDate"];
            model.isFinished = todo["isFinished"];
            _todoList.add(model);
          });
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My ToDo App"),
      ),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_todoList[index].title ?? "No title"),
                  ],
                ),
              ),
            );
          }),
      drawer: DrawerNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TodoScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
