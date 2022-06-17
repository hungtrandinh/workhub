import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workhub/data/model/custom_error.dart';
import 'package:workhub/ui/page/signup_page.dart';
import 'package:workhub/value/app_colors.dart';

import '../../common/utils/error_dialog.dart';
import '../../provider/signin/signin_provider.dart';
import '../../provider/signin/signin_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const String routerName = "/signIn";

  @override
  State<StatefulWidget> createState() {
    return SignInPageState();
  }
}

class SignInPageState extends State<SignInPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  void _submit() async {
    try {
      await context
          .read<SignInProvider>()
          .signIn(email: email.text, password: password.text);
    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signInState = context.watch<SignInProvider>().state;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                    shrinkWrap: true,
                    children: [
                      Image.asset(
                        "assets/images/tinder.png",
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 120.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2)),
                          filled: true,
                          labelStyle: const TextStyle(color: Colors.white),
                          labelText: "Email",
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                        controller: email,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                          ),
                          labelStyle: const TextStyle(color: Colors.white),
                          labelText: "Password",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
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
                            signInState.signInStatus == SignInStatus.submitting
                                ? null
                                : _submit,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          textStyle: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        child:
                            signInState.signInStatus != SignInStatus.submitting
                                ? const Text(
                                    "Sign In",
                                    style: TextStyle(color: Colors.black54),
                                  )
                                : const CircularProgressIndicator(),
                      ),
                      const SizedBox(height: 10.0),
                      TextButton(
                        onPressed:
                            signInState.signInStatus == SignInStatus.submitting
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
                        child: const Text(
                          "Not a member? Sign up!",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
