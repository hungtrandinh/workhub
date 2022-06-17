import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workhub/ui/page/profile_page.dart';
import 'package:workhub/value/strings.dart';
import '../../common/animated/custom_page_route.dart';
import '../../provider/tinder/card_tinder_provider.dart';
import '../../provider/tinder/card_tinder_state.dart';
import '../../value/textstyle_app.dart';
import '../widgets/tinder_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    Strings.nameApp,
                    style: AppTextStyle.appTitle,
                  ),
                ],
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.orange,
            leading: Padding(
              padding: const EdgeInsets.all(10),
              child: Hero(
                tag: "avatar",
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context, CustomPageRoute(const ProfilePage()));
                    },
                    child: ClipOval(
                        child: Image.asset(
                      "assets/images/avatar.jpg",
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    stops: [0.7, 1],
                    colors: [Colors.orange, Colors.pink],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      top: 20, left: 15, right: 15, bottom: 10),
                  child: buildCard()),
            ),
          ),
        ));
  }

  Widget buildCard() {
    final state = context.watch<CardProvider>().cardState;
    if (state.cardState1 == CardStatus1.initial) {
      return Container();
    } else if (state.cardState1 == CardStatus1.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.cardState1 == CardStatus1.errors) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/error.png",
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 20.0),
            const Text(
              "Ooops!\nTry againg",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
    }
    final provider = context.watch<CardProvider>();
    // final images = provider.urlImages;
    final status = provider.getStatus();
    final isLike = status == CardStatus.like;
    final isDislike = status == CardStatus.dislike;
    final isSuperLike = status == CardStatus.superLike;
    return state.post!.isEmpty
        ? Center(
            child: TextButton(
              onPressed: () {
                provider.resetUsers();
              },
              child: const Text("reset"),
            ),
          )
        : Column(
            children: [
              Expanded(
                flex: 8,
                child: Stack(
                  children: state.post!
                      .map((urlImages) => TinderCard(
                          urlImages: urlImages.image,
                          isFont: state.post!.last == urlImages))
                      .toList(),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                getColor(Colors.white, Colors.red, isDislike),
                            shape:
                                MaterialStateProperty.all(const CircleBorder()),
                            foregroundColor:
                                getColor(Colors.red, Colors.white, isDislike),
                            side:
                                getBorder(Colors.red, Colors.white, isDislike)),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.clear,
                            size: 40,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: getColor(
                                Colors.white, Colors.blueAccent, isSuperLike),
                            shape:
                                MaterialStateProperty.all(const CircleBorder()),
                            foregroundColor: getColor(
                                Colors.blueAccent, Colors.white, isSuperLike),
                            side: getBorder(
                                Colors.blueAccent, Colors.white, isSuperLike)),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.star,
                            size: 30,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: getColor(
                                Colors.white, Colors.tealAccent, isLike),
                            shape:
                                MaterialStateProperty.all(const CircleBorder()),
                            foregroundColor: getColor(
                                Colors.tealAccent, Colors.white, isLike),
                            side: getBorder(
                                Colors.tealAccent, Colors.white, isLike)),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.favorite,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          );
  }

  MaterialStateProperty<BorderSide> getBorder(
      Color color, Color colorPressed, bool force) {
    getBorder(Set<MaterialState> states) {
      if (force || states.contains(MaterialState.pressed)) {
        return const BorderSide(color: Colors.transparent);
      } else {
        return BorderSide(color: color, width: 2);
      }
    }

    ;
    return MaterialStateProperty.resolveWith(getBorder);
  }

  MaterialStateProperty<Color> getColor(
      Color color, Color colorPressed, bool force) {
    getColor(Set<MaterialState> states) {
      if (force || states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    }

    ;
    return MaterialStateProperty.resolveWith(getColor);
  }
}
