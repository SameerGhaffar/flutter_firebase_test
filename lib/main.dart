import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_test/ui/home/home.dart';
import 'package:flutter_firebase_test/ui/login/login.dart';
import 'package:flutter_firebase_test/services/firebase_auth.dart';
import 'package:flutter_firebase_test/ui/signup/sign_up.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CheckData(),
    );
  }
}

class CheckData extends StatefulWidget {
  const CheckData({super.key});
  @override
  State<CheckData> createState() => _CheckDataState();
}

class _CheckDataState extends State<CheckData> {
  bool isDataLoad =true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    await Future.delayed(const Duration(seconds: 2));
  User? user =  AuthService().user;
      if(user == null){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login(),),(route)=> false);
      }else{
        if(user.emailVerified){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Home(),),(route)=> false);
        }
      }
  }
  @override
  Widget build(BuildContext context) {
    // return const Scaffold(
    //   body: SafeArea(
    //     child: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   ),
    // );
    return const Scaffold(
      
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }


}
