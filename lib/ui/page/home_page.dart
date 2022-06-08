import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workhub/provider/auth/auth_provider.dart';
import 'package:workhub/ui/page/signIn_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:const Text("Home"),

          ),
        body: const Center(
          child: Text("Center"),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: (){
            context.read<AuthProvider>().signOut();
            Navigator.push(context, MaterialPageRoute(
              builder: (context) =>const SignInPage()
            ),);
    },
          child: Text("logout"),


        ),
        ),


    );
  }
}
