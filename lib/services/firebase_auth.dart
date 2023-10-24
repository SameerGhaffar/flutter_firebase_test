import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/phonelogin/otp.dart';
import 'package:flutter_firebase_test/services/snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final User? user = _auth.currentUser;
  FirebaseAuth get auth => _auth;
  String? _error;
  String verificationId = '';

  String? error() {
    return _error;
  }


  Future<bool> signUpWithGoogle() async {
    try{
      await googleSignIn.signOut();
      GoogleSignInAccount? gUserAcc=  await googleSignIn.signIn();
      if (gUserAcc == null) {
        return false;
      }
      GoogleSignInAuthentication gAuthentication = await gUserAcc.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential( accessToken: gAuthentication.accessToken,idToken: gAuthentication.idToken);
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
       return true;
    } on FirebaseAuthException catch (e){
      print(e.code.toUpperCase().replaceAll("-", " "));
      return false;
    }


  }

  static Future<bool> signUp(String email , String password) async {
    try{
     await _auth.createUserWithEmailAndPassword(email: email, password: password);
     return true;
    }on FirebaseAuthException catch (e){
      print("Catched in SignAuth : E > ${e.code}");
      return false;
    }
  }
  

    Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      _error =e.code;
      print(e.code.toUpperCase().replaceAll("-", " "));
      return false;
    }
  }

  Future<bool> phoneLogin(String phoneNo, BuildContext context) async {
    try {
      await AuthService().auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) async {
         await auth.signInWithCredential(credential);
        },
        codeSent: (String vId, int? resendToken) {
          print("Verification id is get in verify Number");
          print("verification id  = $vId");
         verificationId = vId;


        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Otp(vID: verificationId,)));
        },
        codeAutoRetrievalTimeout: (String vId) {
          verificationId = vId;
        },
        verificationFailed: (FirebaseAuthException e) {
          _error=e.code;
        },
      );
      return true;
    } on FirebaseAuthException catch (e) {
      _error =e.code;
      print(e.code.toUpperCase().replaceAll("-", " "));
      return false;
    }
  }

  Future<bool> verifyOTP(String otp, String vId) async {
    try{
      print("Verification id in OTp = $verificationId");
     var userCredentials= await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: vId, smsCode: otp));
     if(userCredentials== null){
       print("UserCredentials is null");
     }

     return (userCredentials.user !=null) ? true : false;
    } catch (e){
      print(e);
      return false;
    }
  }

  static Future<bool> signOut() async {
    try {
      // await GoogleSignIn().signOut();
      await _auth.signOut();
      return true;
    }on FirebaseAuthException catch (e) {
      print(e.code.toUpperCase().replaceAll("-", " "));
      return false;
    }
  }
}