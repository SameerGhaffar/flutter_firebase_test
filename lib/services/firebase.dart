import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_test/model/Image_model.dart';
import 'package:flutter_firebase_test/model/task_model.dart';

class FirebaseService {

  final CollectionReference users =
      FirebaseFirestore.instance.collection('TODO');
  final CollectionReference images =
  FirebaseFirestore.instance.collection('Images');


  getTodoStream(){
   return users.snapshots();
  }
  getImagesStream(){
    return images.snapshots();
  }

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
  addImage(String url) async {
    try {
      DocumentReference doc= images.doc();
      ImageModel imageModel = ImageModel(docId: doc.id,imageUrl: url);
      await doc.set(imageModel.toMap());
      return true;
    } catch (e) {
      print(e);
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
  deleteImage(String? docId){
    try{
      if(docId != null){
        images.doc(docId).delete();
      }
    } catch(e){
      print(e);
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
