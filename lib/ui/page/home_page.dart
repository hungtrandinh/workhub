import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:workhub/provider/auth/auth_provider.dart';
import 'package:workhub/ui/page/signIn_page.dart';
import 'package:workhub/ui/widgets/list_book.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.menu_sharp,
                color: Colors.grey,
              ),
            )
          ],
          leading: const Icon(
            Icons.account_circle_outlined,
            color: Colors.grey,
          ),
          title: const Center(child: Text("Home")),
        ),
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicator: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5), topLeft: Radius.circular(5)),
                color: Colors.blue,
              ),
              tabs: const [
                Tab(
                  icon: Text("ル過ぎ"),
                ),
                Tab(
                  icon: Icon(Icons.beach_access_sharp),
                ),
                Tab(
                  icon: Icon(Icons.brightness_5_sharp),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 5,
              color: Colors.blue,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  ListBook(),
                  Center(
                    child: Text("It's rainy here"),
                  ),
                  Center(
                    child: Text("It's sunny here"),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            context.read<AuthProvider>().signOut();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignInPage()),
            );
          },
          child: const Text("logout"),
        ),
      ),
    );
  }
}
