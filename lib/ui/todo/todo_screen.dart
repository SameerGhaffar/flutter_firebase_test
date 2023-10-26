import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/model/task_model.dart';
import 'package:flutter_firebase_test/services/dialog.dart';
import 'package:flutter_firebase_test/services/firestore.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final DialogService _dialogService = DialogService();
  final FirestoreService _firestoreService = FirestoreService();

  List<TaskModel> taskList = [];

  @override
  void initState() {
    super.initState();

    _firestoreService.users.snapshots().listen((event) {
      taskList.clear();
      taskList = List.generate(
        event.size,
        (index) => TaskModel.fromMap(
            event.docs[index] as DocumentSnapshot<Map<String, dynamic>>),
      );
      setState(() {});
    });
  }

  TaskModel getTaskData(int index) {
    return taskList[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TODO',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: taskCard(index),
              ),
              itemCount: taskList.length,
            ),
          ),
          Container(
            height: 80,
            alignment: Alignment.center,
            child: FloatingActionButton(
              onPressed: () => onclickFAB(),
              elevation: 10,
              backgroundColor: Colors.redAccent,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget taskCard(int index) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getTaskData(index).task,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    getTaskData(index).date,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 16),
                  ),
                ],
              ),
            ),),
            IconButton(
              onPressed: () {
                _dialogService.showAddDialog(context,
                    isEdit: true, taskModel: getTaskData(index));
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.blueAccent,
              ),
            ),
            IconButton(
              onPressed: () {
                _firestoreService.deleteTask(getTaskData(index).docId);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  onclickFAB() {
    _dialogService.showAddDialog(context);
  }
}
