import 'package:flutter/material.dart';
import 'package:workhub/ui/widgets/swiper_widget.dart';
import 'package:workhub/value/textstyle_app.dart';

class ListBook extends StatefulWidget {
  const ListBook({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListBookState();
  }
}

class ListBookState extends State<ListBook> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.grey,
            tabs: const [
              Tab(
                child: Text(
                  "ル過ぎ",
                  style: AppTextStyle.txtTabbar,
                ),
              ),
              Tab(
                child: Text(
                  "ル過ぎ",
                  style: AppTextStyle.txtTabbar,
                ),
              ),
            ]),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Column(
              children: const [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  child: SwiperCustoms(),
                ),
              ],
            ),
            const Center(
              child: Text("It's rainy here"),
            ),
          ],
        ))
      ],
    );
  }
}
