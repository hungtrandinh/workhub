import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workhub/provider/auth/auth_provider.dart';
import 'package:workhub/provider/drawing/drawing_provider.dart';
import 'package:workhub/provider/image/image_provider.dart';
import 'package:workhub/provider/signin/signin_provider.dart';
import 'package:workhub/provider/signup/signup_provider.dart';
import 'package:workhub/provider/tinder/card_tinder_provider.dart';
import 'package:workhub/ui/page/drawing_page.dart';

import 'data/repository/export_reponsitory.dart';
import 'ui/page/export_page.dart';

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
        Provider<PostRepository>(
          create: (context) =>PostRepository(),
        ),
        Provider<ImageRepository>(
          create: (context) =>ImageRepository(),
        ),
        Provider<AuthenticationRepository>(
            create: (context) => AuthenticationRepository(
                  firebaseAuth: auth.FirebaseAuth.instance,
                )),
        ChangeNotifierProvider(create: (context)=>DrawingProvider()),
        ChangeNotifierProvider(create: (context)=>CardProvider(
          postRepository: context.read<PostRepository>()
        )),
        ChangeNotifierProvider<ImageApiProvider>(create: (context)=>ImageApiProvider(
            imageRepository: context.read<ImageRepository>())),
        ChangeNotifierProvider<SignUpProvider>(
            create: (context) => SignUpProvider(
                authenticationRepository:
                    context.read<AuthenticationRepository>())),
        ChangeNotifierProvider<SignInProvider>(
            create: (context) => SignInProvider(
                authenticationRepository:
                    context.read<AuthenticationRepository>())),
        StreamProvider<auth.User?>(
          create: (context) => context.read<AuthenticationRepository>().user,
          initialData: null,
        ),
        ChangeNotifierProxyProvider<auth.User?, AuthProvider>(
          create: (context) => AuthProvider(
              authenticationRepository:
                  context.read<AuthenticationRepository>()),
          update: (BuildContext context, auth.User? userStream,
                  AuthProvider? authProvider) =>
              authProvider!..update(userStream),
        )
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
          DrawingPage.routeName: (context) => const DrawingPage()
        },
      ),
    );
  }
}
