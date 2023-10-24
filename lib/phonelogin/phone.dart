import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/home/home.dart';
import 'package:flutter_firebase_test/phonelogin/otp.dart';
import 'package:flutter_firebase_test/services/firebase_auth.dart';
import 'package:flutter_firebase_test/signup/sign_up.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  bool isObscure = true;
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildTextField(
                        phoneController, "Phone no", "Enter Phone no",validator: phoneValidator),
                      ElevatedButton(
                        onPressed: () => onPhoneLoginTap(),
                        child: const Text('Login with Phone'),
                      ),

                    ],
                  ),
                ),
            ),
          ),


        ],
      ),
    );
  }


  TextFormField buildTextField(TextEditingController emailController, String label, String hint, {bool isPassword = false, String? Function(String?)? validator}) {
    return TextFormField(
      validator: validator,
      keyboardType: TextInputType.phone,
      controller: emailController,
      obscureText: isPassword ? isObscure : false,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? GestureDetector(
            onTap: () => onEyeTap(),
            child: isObscure
                ? Icon(Icons.visibility_off,color: Colors.black,)
                : Icon(Icons.visibility,color: Colors.black,))
            : null,
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.black),
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
        border: InputBorder.none,
        fillColor: Colors.black12,
        filled: true,

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
    );
  }

  void onEyeTap() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  Future<void> onPhoneLoginTap() async {

    if (formKey.currentState!.validate()) {
      String phone = phoneController.text.toString().trim();
     if(await AuthService().phoneLogin(phone, context)){
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Otp(),));
     }



    }
  }


  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone is required";
    }
    if (value.length < 10) {
      return "Phone must be at least 11 characters long";
    }
    return null; // Return null if the input is valid
  }



  }


