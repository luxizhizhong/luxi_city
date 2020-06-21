
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luxi_city/config/const.dart';
import 'package:luxi_city/views/app/home.dart';

class MainApplication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainApplicationState();
  }

}

class MainApplicationState extends State<MainApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomMenusBar.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item['icon']),
            title: Text(item['title']),
          );
        }).toList(),
      ),
      body: AppHomeView(),
    );
  }

}