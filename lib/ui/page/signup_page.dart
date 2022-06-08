import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workhub/provider/signup/signup_state.dart';
import 'package:workhub/ui/page/signIn_page.dart';

import '../../data/model/custom_error.dart';
import '../../provider/signup/signup_provider.dart';
import '../../provider/signin/signin_provider.dart';
import '../../utils/error_dialog.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String routeName = "/signUp";

  @override
  State<StatefulWidget> createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  void _submit() async {

    try {
      await context
          .read<SignUpProvider>()
          .signUp( email: email.text, password:password.text);
    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }
  @override
  Widget build(BuildContext context) {
    final signUpState = context.watch<SignUpProvider>().state;
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            child: ListView(
              reverse: true,
              shrinkWrap: true,
              children: [
                Image.asset(
                  "assets/images/flutter_logo.png",
                  width: 250,
                  height: 250,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: "Name",
                    prefixIcon: Icon(Icons.account_box),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Name required";
                    }
                    if (value.trim().length < 2) {
                      return "Name must be at least 2 characters long";
                    }
                    return null;
                  },

                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),



                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password required";
                    }
                    if (value.trim().length < 6) {
                      return "Password must be at least characters long";
                    }
                    return null;
                  },

                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  obscureText: true,
                  decoration:const  InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock),
                  ),

                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed:
                  signUpState.signUpStatus== SignUpStatus.submitting
                      ? null
                      : _submit,
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  child: Text(
                    signUpState.signUpStatus== SignUpStatus.submitting
                        ? "Loading..."
                        : "Sign up",
                  ),
                ),
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed:
                  signUpState.signUpStatus== SignUpStatus.submitting
                      ? null
                      : () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 20.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  child: const Text("Already a member? Sign in!"),
                )
              ].reversed.toList(), // 모든 element들이 keyboard 위로 표시되게 하기 위함.
            ),
          ),
        ),
      ),
    );
  }
}
