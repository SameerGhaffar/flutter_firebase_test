import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/model/task_model.dart';
import 'package:flutter_firebase_test/services/firebase_auth.dart';
import 'package:flutter_firebase_test/services/firestore.dart';
import 'package:intl/intl.dart';

class TaskDialog extends StatefulWidget {
  const TaskDialog({super.key, this.isEdit = false, this.taskModel});

  final bool isEdit;
  final TaskModel? taskModel;

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  TextEditingController taskController = TextEditingController();
  DateTime? date;
  String? selectedDate;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
    if (widget.taskModel != null) {
      selectedDate = widget.taskModel!.date.toString();
      taskController.text = widget.taskModel!.task;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          height: 300,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextField(
                    taskController, "Enter Task", "Enter Task Todo here",
                    validator: taskValidator),
                Row(
                  children: [
                    const Text("Time : ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),),
                    RichText(
                      text: TextSpan(
                        children: [
                          date != null || selectedDate != null
                              ? TextSpan(
                                  text: selectedDate,
                                  style: const TextStyle(color: Colors.black),)
                              : TextSpan(
                                  text: '"Please Select Date "',
                                  style: TextStyle(
                                      color: Colors.red.withOpacity(0.4),
                                      fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                          onTap: () async {
                            date = await showDatePicker(
                              context: context,
                              keyboardType: TextInputType.number,
                              barrierColor: Colors.white,
                              currentDate: DateTime.now(),
                              helpText: "Select Date for TODO Task",
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2025),
                            );
                            selectedDate =
                                DateFormat.yMMMd().format(date!).toString();
                            setState(() {});
                          },
                          child: const Icon(Icons.add),),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.redAccent.withOpacity(0.6),),),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () =>
                          widget.isEdit ? onClickUpdate() : onClickUpload(),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.lightGreenAccent.withOpacity(0.6))),
                      child: Text(
                        widget.isEdit ? 'Update' : "Upload",
                        style: const TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      TextEditingController emailController, String label, String hint,
      {String? Function(String?)? validator}) {
    return TextFormField(
      validator: validator,
      controller: emailController,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.black),
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        fillColor: Colors.black12,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
    );
  }

  String? taskValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Task is required";
    }

    return null;
  }

  onClickUpload() async {

    if (formKey.currentState!.validate()) {
      String taskText = taskController.text.toString();
      if (selectedDate != null) {
        TaskModel taskModel = TaskModel(
            task: taskText, date: selectedDate!, uId: _authService.user!.uid);
        if (await _firestoreService.addTask(taskModel)) {
          Navigator.pop(context);
        }
      }
    }
  }

  onClickUpdate(){
    if (formKey.currentState!.validate()) {
      String taskText = taskController.text.toString();

      if (selectedDate != null || date.toString() != null) {
        TaskModel taskModel = TaskModel(
            task: taskText,
            date: selectedDate ?? date.toString(),
            uId: widget.taskModel!.uId,
            docId: widget.taskModel!.docId);

        _firestoreService.updateTaskAndDate(taskModel);
      }

      Navigator.pop(context);
    }
  }
}
