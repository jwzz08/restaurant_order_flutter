import 'package:flutter/material.dart';
import 'package:restaurant_order/common/layout/default_layout.dart';

import '../const/colors.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;

  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //vsync에는 무조건 with singletickerproviderstatemixin 추가한 다음 현재 클래스(this)를 넣어주면 됨.
    controller = TabController(length: 4, vsync: this);

    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(tabListener);

    super.dispose();
  }

  void tabListener(){
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      child: TabBarView(
        //screen 옆으로 스와이프 안됨
        physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            Center(child: Container(child: Text('홈'))),
            Center(child: Container(child: Text('음식'))),
            Center(child: Container(child: Text('주문'))),
            Center(child: Container(child: Text('프로필'))),
          ]),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: BODY_TEXT_COLOR,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            controller.animateTo(index);
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: '홈'),
            BottomNavigationBarItem(
                icon: Icon(Icons.fastfood_outlined), label: '음식'),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined), label: '주문'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: '프로필'),
          ]),
    );
  }
}
