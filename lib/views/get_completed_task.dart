import 'package:flutter/material.dart';
import 'package:flutter_b11_firebase/models/task.dart';
import 'package:flutter_b11_firebase/services/task.dart';
import 'package:flutter_b11_firebase/views/create_task.dart';
import 'package:provider/provider.dart';

class GetCompletedTaskView extends StatelessWidget {
  const GetCompletedTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Completed Tasks"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTaskView()));
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: TaskServices().getCompletedTask(),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(taskList[i].title.toString()),
                  subtitle: Text(taskList[i].description.toString()),
                );
              });
        },
      ),
    );
  }
}
