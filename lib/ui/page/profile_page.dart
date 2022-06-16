import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../value/textstyle_app.dart';
import '../widgets/card_custom.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: CardPainter(),
        child: Column(
          children: [
            AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ))
              ],
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Center(
                  child: Text(
                "Ho So",
                style: AppTextStyle.txtHoSo,
              )),
            ),
            Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 180,
                    child: Stack(
                      children: [
                        Center(
                          child: CircularPercentIndicator(
                            lineWidth: 12,
                            startAngle: 180,
                            animation: true,
                            animationDuration: 2000,
                            center: Hero(
                              tag: "avatar",
                              child: Material(
                                color: Colors.transparent,
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/images/avatar.jpg",
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            radius: 85,
                            percent: 0.45,
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0.0, 1),
                          child: Card(
                            color: Colors.amber,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const SizedBox(
                              width: 100,
                              height: 35,
                              child: Center(child: Text("45%")),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Tran Dinh Hung",
              style: AppTextStyle.nameUser,
            )
          ],
        ),
      ),
    );
  }
}
