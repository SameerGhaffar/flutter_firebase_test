import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/services/firebase_auth.dart';

import '../home/home.dart';
import '../login/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isObscure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                        emailController,
                        "Email",
                        "Enter Email",
                        validator: (v) => emailValidator(v),
                      ),
                      buildTextField(
                          passwordController, "Password", "Enter Password",
                          isPassword: true,
                          validator: (v) => passwordValidator(v)),
                      ElevatedButton(
                        onPressed: () => onSignUpTap(),
                        child: const Text('SignUp'),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(text: 'Already have a Account ? ',style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: ' Login ',
                            style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login(),),(route)=>false);

                              }),
                      ])),
                      ElevatedButton(
                        onPressed: () => onGoogleTap(),
                        child: const Text('SignUp With Google'),
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  TextFormField buildTextField(
      TextEditingController emailController, String label, String hint,
      {bool isPassword = false, String? Function(String?)? validator}) {
    return TextFormField(
      validator: validator,
      keyboardType: isPassword ? TextInputType.emailAddress : null,
      controller: emailController,
      obscureText: isPassword ? isObscure : false,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? GestureDetector(
                onTap: () => onEyeTap(),
                child: isObscure
                    ? const Icon(
                        Icons.visibility_off,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.visibility,
                        color: Colors.black,
                      ))
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

  Future<void> onSignUpTap() async {
    print("SignUp Press");
    if (formKey.currentState!.validate()) {
      String email = emailController.text.toString();
      String password = passwordController.text.toString();

      bool isUserCreated = await AuthService.signUp(email, password);
      if (isUserCreated) {
        print('User Created');
        emailController.clear();
        passwordController.clear();
      }
    }
  }

  String? emailValidator(String? value) {
    String email = emailController.text.toString();
    bool isValid = EmailValidator.validate(email);

    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!isValid) {
      return "Please Enter Valid Email";
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null; // Return null if the input is valid
  }

 void onGoogleTap() async {
    bool isLogin = await AuthService().signUpWithGoogle();
    print("Islogin = $isLogin");
    if(isLogin){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home(),),(route)=> false);
    }


 }
}
