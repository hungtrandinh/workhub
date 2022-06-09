import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class SwiperCustoms extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SwiperState();
  }

}
class SwiperState extends State<SwiperCustoms>{
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          "https://via.placeholder.com/288x188",
          fit: BoxFit.fill,
        );
      },
      itemCount: 10,
      viewportFraction: 0.8,
      scale: 0.9,
    );

  }

}