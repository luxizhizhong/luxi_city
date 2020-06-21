
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppHomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppHomeViewState();
  }

}

class AppHomeViewState extends State<AppHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .4,
        backgroundColor: Colors.white,
        title: Text(
          "泸溪同城",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),
        ),
        centerTitle: false,
        leading: Container(
          child: Image.asset("assets/images/logo.jpg"),
          padding: EdgeInsets.all(6),
          // decoration: BoxDecoration(
          //   color: Colors.yellow[100]
          // ),
        ),
        actions: <Widget>[
          _topIconActions()
        ],
      ),
    );
  }

  Widget _topIconActions() {
    /**
     * 操作栏
     */
    List<Map> actions = [
      {
        "icon": Icon(CupertinoIcons.search)
      },
      {
        "icon": Icon(CupertinoIcons.bus)
      },
      {
        "icon": Icon(CupertinoIcons.news_solid)
      }
    ];
    Color _iconColor = Theme.of(context).accentColor;
    return Row(
      children: actions.map((item) {
        return GestureDetector(
          child: IconButton(
            color: _iconColor,
            icon: item['icon'],
            onPressed: (){},
            padding: EdgeInsets.all(0),
          ),
        );
      }).toList(),
    );
  }

}