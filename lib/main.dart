import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workhub/data/repository/authen_repository.dart';
import 'package:workhub/provider/signup/signup_provider.dart';
import 'package:workhub/provider/signin/signin_provider.dart';
import 'package:workhub/ui/page/signIn_page.dart';
import 'package:workhub/ui/page/signup_page.dart';
import 'package:workhub/ui/page/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
            create: (context) => AuthenticationRepository(
                  firebaseAuth: FirebaseAuth.instance,
                )),
        ChangeNotifierProvider<SignUpProvider>(
            create: (context) => SignUpProvider(
                authenticationRepository:
                    context.read<AuthenticationRepository>())),
        ChangeNotifierProvider(create: (context) => SignInProvider(authenticationRepository: context.read<AuthenticationRepository>()))
      ],
      child: MaterialApp(
        title: 'Auth Provider',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashPage(),
        routes: {
          SignInPage.routerName: (context) => const SignInPage(),
          SignUpPage.routeName: (context) => const SignUpPage(),
        },
      ),
    );
  }
}
