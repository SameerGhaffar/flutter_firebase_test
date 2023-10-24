import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/services/firebase_auth.dart';

import '../login/login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),centerTitle: true,),
      body: Column(
        children: [
          Center(
            child: Text('Home'),
          ),
          ElevatedButton(onPressed: () async {
    bool isSignout =await AuthService.signOut();
    if(isSignout){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login(),),(route)=> false);
    }

    }, child: Text("SignOut")),
        ],
      ),
    );
  }
}
