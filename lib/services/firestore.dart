import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_test/model/task_model.dart';

class FirestoreService {

  final CollectionReference users =
      FirebaseFirestore.instance.collection('TODO');

  addTask(TaskModel taskModel) async {
    try {
      DocumentReference docId= users.doc();
      taskModel.docId = docId.id;
      docId.set(taskModel.toMap());
      return true;
    } catch (e) {

      return false;
    }
  }

  deleteTask(String? docId){
    try{
      if(docId != null){
        users.doc(docId).delete();
      }
    } catch(e){

    }
  }

  updateTaskAndDate(TaskModel taskModel){
   users.doc(taskModel.docId).update(taskModel.toUpdateTaskAndDate());
  }
  updateTask(TaskModel taskModel){
    users.doc(taskModel.docId).update(taskModel.toUpdateTask());
  }
  updateDate(TaskModel taskModel){
    users.doc(taskModel.docId).update(taskModel.toUpdateDate());
  }


  // i dont know why this method does not run
  //
  // List<TaskModel> taskList = [];
  //
  // getTaskList() {
  //
  //   users.snapshots().listen((event) {
  //     taskList.clear();
  //     taskList = List.generate(
  //         event.size,
  //             (index) => TaskModel.fromMap(
  //             event.docs[index] as DocumentSnapshot<Map<String, dynamic>>));
  //
  //   });
  // }
}
