
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String uId;
  String? docId;
  String task;
  String date;

  TaskModel({required this.task, required this.date,required this.uId, this.docId});

  Map<String, dynamic> toMap() {
    return {
      'task': task,
      'date': date,
      'uId': uId,
      'docId':docId
    };
  }
  Map<String, dynamic> toUpdateDate() {
    return {
      'date': date,
    };
  }
  Map<String, dynamic> toUpdateTaskAndDate() {
    return {
      'task': task,
      'date': date,
    };
  }
  Map<String, dynamic> toUpdateTask() {
    return {
      'task': task,
    };
  }

  factory TaskModel.fromMap(DocumentSnapshot<Map<String, dynamic>> snap) {
    Map<String, dynamic> map = snap.data()!;
    return TaskModel(
        task: map['task'],
        date: map['date'],
        uId: map['uId'],
        docId:map['docId'],
    );
  }

}
