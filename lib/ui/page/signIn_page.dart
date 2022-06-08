import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workhub/data/model/custom_error.dart';
import 'package:workhub/provider/signup/signup_provider.dart';
import 'package:workhub/provider/signup/signup_state.dart';
import 'package:workhub/ui/page/signup_page.dart';
import 'package:workhub/utils/error_dialog.dart';

import '../../provider/signin/signin_provider.dart';
import '../../provider/signin/signin_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const String routerName ="/signIn";

  @override
  State<StatefulWidget> createState() {
    return SignInPageState();

  }

}

class SignInPageState extends State<SignInPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password =TextEditingController();


  void _submit() async {
    try {
      await context.read<SignInProvider>().signIn(
          email: email.text, password: password.text);

    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signInState = context.watch<SignInProvider>().state;

    return WillPopScope(
        onWillPop: () async => false,
        child:  Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(

                child: ListView(
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
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      controller: email,

                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
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
                       controller: password,
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed:
                      signInState.signInStatus== SignInStatus.submitting
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
                        signInState.signInStatus== SignInStatus.submitting
                            ? "Loading..."
                            : "Sign in",
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextButton(
                      onPressed:
                      signInState.signInStatus== SignInStatus.submitting
                          ? null
                          : () {
                        Navigator.pushNamed(
                            context, SignUpPage.routeName);
                      },
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      child: const Text("Not a member? Sign up!"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

}