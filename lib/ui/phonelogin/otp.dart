
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/ui//home/home.dart';
import 'package:flutter_firebase_test/ui/login/login.dart';
import 'package:flutter_firebase_test/services/firebase_auth.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class Otp extends StatelessWidget {
  const Otp({super.key, required this.vID});

  final String vID;
  @override
  Widget build(BuildContext context) {

    print("-------------");
    print(vID);


    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController smsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Confirmation'),
        centerTitle: true,
      ),
      body: Column(

        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: formKey,
              child: SizedBox(
                height: 300,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PinCodeTextField(
                        autofocus: true,
                        controller: smsController,
                        pinBoxHeight: 40,
                        pinBoxWidth: 40,
                        highlight: true,
                        highlightColor: Colors.blue.withOpacity(0.3),
                        defaultBorderColor: Colors.black,
                        maxLength: 6,
                        onDone: (text) => confirmOTP(text,vID,context),

                      ),
                      SizedBox(height: 12,),
                      Text("Enter OTP here")
                    ],
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );

  }
  confirmOTP(String text,String vId,BuildContext context) async {

    if(await AuthService().verifyOTP(text.toString().trim(),vId)){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home(),), (route) => false);
    }else{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login(),), (route) => false);

    }
  }



}
