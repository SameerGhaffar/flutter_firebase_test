import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/home/home.dart';
import 'package:flutter_firebase_test/phonelogin/phone.dart';
import 'package:flutter_firebase_test/services/firebase_auth.dart';
import 'package:flutter_firebase_test/services/snackbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_firebase_test/signup/sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: Form(
                key: formKey,
                child: SizedBox(
                  height: 450,
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
                        passwordController,
                        "Password",
                        "Enter Password",
                        isPassword: true,
                      ),
                      ElevatedButton(
                        onPressed: () => onLoginTap(),
                        child: const Text('Login'),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            text: 'Need an Account ? ',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: ' SignUp Now ',
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const SignUp(),
                                    ),
                                    (route) => false);
                              }),
                      ])),
                      Card(
                        elevation: 4,
                        child: Container(
                          width: 200,
                          padding: EdgeInsets.all(6),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(

                            children: [
                              Spacer(),
                              Image.asset(
                                'assets/images/google.png',
                                width: 35,
                                height: 35,
                              ),
                              Spacer(),
                              const Text('SignUp With Google',style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => onPhoneTap(),
                        child: const Text('SignUp With Phone'),
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
                    ? Icon(
                        Icons.visibility_off,
                        color: Colors.black,
                      )
                    : Icon(
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

  Future<void> onLoginTap() async {
    if (formKey.currentState!.validate()) {
      String password = passwordController.text.toString();
      String email = emailController.text.toString();

      bool isUserLogin = await AuthService().login(email, password);
      if (isUserLogin) {
        emailController.clear();
        passwordController.clear();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
            (route) => false);
        print('User Logined');
      } else {
        String? error = AuthService().error();
        SnackBarService.showSnackBar(
            error?.toUpperCase().replaceAll("-", " ") ?? 'User Not Login',
            context);
      }
    }
  }

  void onGoogleTap() async {
    bool isLogin = await AuthService().signUpWithGoogle();
    if (isLogin) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
          (route) => false);
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

  onPhoneTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PhoneLogin(),
    ));
  }
}
