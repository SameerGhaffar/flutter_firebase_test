import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/dialog/task_dialog.dart';
import 'package:flutter_firebase_test/model/Image_model.dart';
import 'package:flutter_firebase_test/model/task_model.dart';
import 'package:flutter_firebase_test/services/firebase.dart';

class DialogService {
  Future<void> showAlertDialog(BuildContext context,String docId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return _alertDialog(context,docId);
      },
    );
  }

  Future<void> showAddDialog(BuildContext context, {bool isEdit=false,TaskModel? taskModel}) async {

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return TaskDialog(isEdit: isEdit,taskModel: taskModel,);
      },
    );
  }

  AlertDialog _alertDialog(BuildContext context,String docId) {
    return AlertDialog(
      title: Text("Do you really want to delete ?"),
      actions: [
        ElevatedButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const Spacer(),
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent.withOpacity(0.7))),
          onPressed: () {
           FirebaseService firebase =FirebaseService();
           firebase.deleteImage(docId);
           Navigator.of(context).pop();
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.black),
          ),
          
          
        ),
      ],
    );
  }
}
