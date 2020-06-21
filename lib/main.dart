import 'package:flutter/material.dart';
import 'package:luxi_city/pages/app.dart';

void main() => runApp(LuxiCityApplication());

class LuxiCityApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/": (BuildContext ctx)=> MainApplication(),
      },
    );
  }

}