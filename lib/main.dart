import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:luxi_city/pages/app.dart';

void main() => runApp(LuxiCityApplication());

class LuxiCityApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _ApplicationInit();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/": (BuildContext ctx)=> MainApplication(),
      },
    );
  }

  void _ApplicationInit() {
    // TODO 初始化适配
    ScreenUtil.init(); 
  }

}