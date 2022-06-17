import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workhub/provider/image/image_provider.dart';
import 'package:workhub/provider/image/image_state.dart';
import 'package:workhub/value/strings.dart';

class SwiperCustoms extends StatefulWidget {
  const SwiperCustoms({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SwiperState();
  }
}

class SwiperState extends State<SwiperCustoms> {
  late final ImageApiProvider imageProvider;

  @override
  void initState() {
    super.initState();
    context.read<ImageApiProvider>().getImage();
  }

  @override
  Widget build(BuildContext context) {
    var imageStates = context
        .read<ImageApiProvider>()
        .state;
    if (imageStates.imageStatus == ImageStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (imageStates.imageStatus == ImageStatus.loading) {
      return const Center(
        child: Text("no data"),
      );
    } else {
      return Swiper(
        itemBuilder: (BuildContext context, int index) {
          final image = imageStates.imageApi![index];
          return Text(Strings.nameApp);
        },
        layout: SwiperLayout.DEFAULT,
        itemCount: imageStates.imageApi!.length,
        viewportFraction: 0.8,
        scale: 0.9,
      );
    }
  }
}
