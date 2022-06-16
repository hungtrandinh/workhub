import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:workhub/ui/page/profile_page.dart';
import '../../common/animated/custom_page_route.dart';
import '../../provider/tinderprovider/card_tinder_provider.dart';
import '../../value/textstyle_app.dart';
import '../widgets/tinder_card.dart';

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
            title: Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Tinder",
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
    final provider = context.watch<CardProvider>();
    final images = provider.urlImages;
    final status = provider.getStatus();
    final isLike = status == CardStatus.like;
    final isDislike = status == CardStatus.dislike;
    final isSuperLike = status == CardStatus.superLike;
    return images.isEmpty
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
                  children: images
                      .map((urlImages) => TinderCard(
                          urlImages: urlImages,
                          isFont: images.last == urlImages))
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
