import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/services/firebase_auth.dart';
import 'package:flutter_firebase_test/ui/Profile/profile.dart';
import 'package:flutter_firebase_test/ui/images/images_screen.dart';
import 'package:flutter_firebase_test/ui/todo/todo_screen.dart';

import '../login/login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                bool isSignout = await AuthService.signOut();
                if (isSignout) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                      (route) => false);
                }
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          const Center(
            child: Text('Welcome Home'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const TodoScreen(),
            )),
            child: const Text("ToDo"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Profile(),
            )),
            child: const Text("Profile"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ImagesScreen(),
            )),
            child: const Text("Images"),
          ),
        ],
      ),
    );
  }
}
