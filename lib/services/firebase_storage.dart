import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_test/model/Image_model.dart';
import 'package:flutter_firebase_test/services/firebase.dart';
import 'package:mime/mime.dart';

class FirebaseStorageService {
  FirebaseService firebaseService = FirebaseService();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Reference imageRefrence = FirebaseStorage.instance.ref("Images");
  Reference fileRefrence = FirebaseStorage.instance.ref("File");

  uploadImage({required File image}) async {
    try {
      final metadata = lookupMimeType(image.path);
      final UploadTask uploadTask = imageRefrence
          .child(DateTime.now().toIso8601String())
          .putFile(image.absolute,SettableMetadata(contentType: metadata));
      final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() {});
      final String url = (await downloadUrl.ref.getDownloadURL());
      await firebaseService.addImage(url);
      return true;
    } catch (e) {
      print("Image NOt upload");
      return false;
    }
  }

  deleteImage(ImageModel imageModel) async {
    try {
      await FirebaseStorage.instance.refFromURL(imageModel.imageUrl).delete();
      await firebaseService.deleteImage(imageModel.docId);
      return true;
    } catch (e) {
      print("Image NOt deleted");
      return false;
    }
  }

  uploadFile({required File file}) async {
    try {
      final metadata = lookupMimeType(file.path);
      final UploadTask uploadTask = fileRefrence
          .child(DateTime.now().toIso8601String())
          .putFile(file.absolute,SettableMetadata(contentType: metadata));
      final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() {});
      final String url = (await downloadUrl.ref.getDownloadURL());

      print("FILE URL = $url");
      return true;
    } catch (e) {
      print("file not uploaded");
      return false;
    }
  }

}
