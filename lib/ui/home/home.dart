import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/services/firebase_auth.dart';
import 'package:flutter_firebase_test/ui/todo/todo_screen.dart';

import '../login/login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () async {
            bool isSignout = await AuthService.signOut();
            if (isSignout) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                      (route) => false);
            }
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Column(

        children: [
          Center(
            child: Text('Welcome Home'),
          ),

          ElevatedButton(
              onPressed:() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TodoScreen(),)),
              child: Text("ToDo")),

        ],
      ),
    );
  }
}
