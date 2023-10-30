import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/services/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? selectedImage;
  File? selectedFile;
  FirebaseStorageService storageService =FirebaseStorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => pickImage(),
              child: Container(
                height: 400,
                width: 300,
                alignment: Alignment.center,
                color: Colors.blueAccent,
                child: selectedImage != null
                    ? Image.file(selectedImage!)
                    : Text("No Image Selected"),
              ),
            ),
            ElevatedButton(
              onPressed:selectedImage!=null ? () => uploadImage() : null,
              child: const Text("Upload"),
            ),
            InkWell(
              onTap: () => pickfile(),
              child: Container(
                height: 200,
                width: 200,
                alignment: Alignment.center,
                color: Colors.pinkAccent,
                child: selectedFile != null
                    ? Icon(Icons.folder)
                    : Text("No File Selected"),
              ),
            ),
            ElevatedButton(
              onPressed:selectedFile!=null ? () => uploadFile() : null,
              child: const Text("Upload"),
            ),







          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      ImagePicker picker = ImagePicker();
      // You can change this to ImageSource.camera or ImageSource.gallery as needed.
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        setState(() {});
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }
  pickfile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        selectedFile = File(result.files.single.path!);
        setState(() {});
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }
  uploadImage() async {
     final image = selectedImage;
     setState(() {
       selectedImage=null;
     });
     await storageService.uploadImage(image: image!);
  }
  uploadFile() async {
    File? file = selectedFile;
    setState(() {
      selectedFile=null;
    });
    await storageService.uploadFile(file: file!);


  }


}
