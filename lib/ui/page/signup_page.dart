import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workhub/provider/signup/signup_state.dart';
import '../../common/utils/error_dialog.dart';
import '../../data/model/custom_error.dart';
import '../../provider/signup/signup_provider.dart';
import '../../value/app_colors.dart';

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
          .signUp(email: email.text, password: password.text);
    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = context.watch<SignUpProvider>().state;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              stops: [0.5, 1],
              colors: [AppColors.startColor, AppColors.endColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                child: ListView(
                  reverse: true,
                  shrinkWrap: true,
                  children: [
                    Image.asset(
                      "assets/images/tinder.png",
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 80.0,
                    ),
                    TextFormField(
                      autocorrect: false,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                        ),
                        filled: true,
                        labelStyle: const TextStyle(color: Colors.white),
                        labelText: "Name",
                        prefixIcon: const Icon(
                          Icons.account_box,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                        ),
                        filled: true,
                        labelText: "Email",
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                        ),
                        filled: true,
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                        ),
                        filled: true,
                        labelText: "Confirm Password",
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                        onPressed:
                            signUpState.signUpStatus == SignUpStatus.submitting
                                ? null
                                : _submit,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.white)),
                          textStyle: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        child:
                            signUpState.signUpStatus != SignUpStatus.submitting
                                ? const Text(
                                    "Sign Up",style: TextStyle(color: Colors.black54),
                                  )
                                : const CircularProgressIndicator()),
                    const SizedBox(height: 10.0),
                    TextButton(
                      onPressed:
                          signUpState.signUpStatus == SignUpStatus.submitting
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
                      child: const Text(
                        "Already a member? Sign in!",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ].reversed.toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
