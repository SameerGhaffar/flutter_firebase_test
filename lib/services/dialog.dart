import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/dialog/task_dialog.dart';
import 'package:flutter_firebase_test/model/task_model.dart';

class DialogService {
  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return _alertDialog(context);
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

  AlertDialog _alertDialog(BuildContext context) {
    return AlertDialog(
      title: ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Sameer'),
        subtitle: Text(
          'Flutter Developer',
          style: TextStyle(color: Colors.black.withOpacity(0.6)),
        ),
        iconColor: Colors.black,
        trailing: const Icon(
          Icons.verified,
          color: Colors.blue,
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          "Bachelor's in Computer Science from University of Sahiwal",
          style: TextStyle(color: Colors.black.withOpacity(0.6)),
        ),
      ),
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
          child: const Text(
            'Upload',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
