import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b11_firebase/models/task.dart';
import 'package:flutter_b11_firebase/services/task.dart';
import 'package:flutter_b11_firebase/views/create_task.dart';
import 'package:flutter_b11_firebase/views/get_completed_task.dart';
import 'package:flutter_b11_firebase/views/update_task.dart';
import 'package:provider/provider.dart';

import 'get_in_completed_task.dart';

class GetAllTaskView extends StatelessWidget {
  const GetAllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Tasks"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetCompletedTaskView()));
              },
              icon: Icon(Icons.circle)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetInCompletedTaskView()));
              },
              icon: Icon(Icons.incomplete_circle))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTaskView()));
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: TaskServices().getAllTask(),
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CupertinoSwitch(
                          value: taskList[i].isCompleted!,
                          onChanged: (val) async {
                            try {
                              await TaskServices()
                                  .markTaskAsComplete(
                                      taskList[i].docId.toString())
                                  .then((val) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Task has been marked as complete successfully")));
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          }),
                      IconButton(
                          onPressed: () async {
                            try {
                              await TaskServices()
                                  .deleteTask(taskList[i].docId.toString())
                                  .then((val) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Task has been deleted successfully")));
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                      IconButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateTaskView(model: taskList[i])));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          )),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
