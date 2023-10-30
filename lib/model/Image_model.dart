import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {
   String docId;
    String imageUrl;

  ImageModel({required this.docId, required this.imageUrl});

  Map<String , dynamic> toMap(){
    return {'docId' : docId,'imageUrl':imageUrl};
  }


 factory ImageModel.fromMap(DocumentSnapshot <Map<String,dynamic>> snapshot){
    Map<String , dynamic> map = snapshot.data()!;
    return ImageModel(docId: map['docId'], imageUrl: map["imageUrl"]);

  }



}