import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;

  const DefaultLayout({required this.child, this.backgroundColor, this.title, this.bottomNavigationBar, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar() {
    if(title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        //appbar가 앞으로 튀어나와있는 듯한 효과, default 값이 2 or 3정도임, 없는 게 요즘 트렌드
        elevation: 0,
        title: Center(
          child: Text(
            title!,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        foregroundColor: Colors.black,
      );
    }
  }
}
