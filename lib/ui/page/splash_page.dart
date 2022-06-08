import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workhub/provider/auth/auth_provider.dart';
import 'package:workhub/ui/page/signIn_page.dart';

import '../../provider/auth/auth_state.dart';
import 'home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthProvider>().state;

    if (authState.authStatus == AuthStatus.authenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, HomePage.routeName);
      });
    } else if(authState.authStatus == AuthStatus.unauthenticated)  {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, SignInPage.routerName);
      });
    }
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
