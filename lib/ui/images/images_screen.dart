import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/model/Image_model.dart';
import 'package:flutter_firebase_test/services/dialog.dart';
import 'package:flutter_firebase_test/services/firebase.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  List<ImageModel> imageList = [];
  FirebaseService firebaseService = FirebaseService();
  DialogService dialogService=DialogService();

  ImageModel getImageData(int index) {
    return imageList[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Images Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder(
          stream: firebaseService.getImagesStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: const Text("No image Found"),
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }

            imageList = List.generate(
              snapshot.data!.docs.length,
              (index) => ImageModel.fromMap(snapshot.data!.docs[index]
                  as DocumentSnapshot<Map<String, dynamic>>),
            );
            return SizedBox(
              width: 300,
              child: ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),
                  child: InkWell(
                    onTap:() => delete(getImageData(index).docId),
                    child: Card(
                      elevation: 4,
                      child: ClipRRect(
                        borderRadius:BorderRadius.circular(12) ,
                        child: Image.network(
                          getImageData(index).imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                itemCount: imageList.length,

              ),
            );
          },
        ),
      ),
    );
  }

  delete(String docId) {
    dialogService.showAlertDialog(context, docId);
  }
}
