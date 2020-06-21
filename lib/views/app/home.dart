
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:luxi_city/api/luxi.dart';
import 'package:luxi_city/config/const.dart';

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
          ConstKey.title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),
        ),
        centerTitle: false,
        leading: Container(
          child: Image.asset("assets/images/logo.jpg"),
          padding: EdgeInsets.all(6.66),
          // decoration: BoxDecoration(
          //   color: Colors.yellow[100]
          // ),
        ),
        actions: <Widget>[
          _topIconActions()
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _banner(),
            _menus()
          ],
        )
      )
    );
  }

  Widget _menus() {
    return FutureBuilder(
      future: LuxiCityApi.getHomeMenus(),
      builder: (context, snapshot) {
        List<Map> lists = snapshot.data;
        List<Widget> _lists = lists.map((item) {
          return _menuItem(item);
        }).toList();
        return Container(
          width: ScreenUtil.screenWidth,
          height: ScreenUtil().setHeight(720),
          margin: EdgeInsets.only(
            top: 24,
            bottom: 12
          ),
          decoration: BoxDecoration(
            // color: Colors.blue
          ),
          child: GridView.count(
            crossAxisCount: 5,
            children: _lists,
          ),
        );
      }
    );
  }

  /**
   * 菜单单个
   */
  Widget _menuItem(Map item) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          child: Image.network(
            item['img']
          ),
        ),
        Text(
          item['title'],
          style: TextStyle(
            fontSize: 12,
            color: Colors.black
          ),
        )
      ],
    );
  }

  /**
   * 轮播图
   */
  Widget _banner() {
    return FutureBuilder(
      future: LuxiCityApi.getHomeBanners(),
      builder: (context, snapshot) {
        var _lists = snapshot.data;
        return Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(666),
          decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24)
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24)
            ),
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  _lists[index]['image'],
                  fit: BoxFit.fill,
                  color: null,
                );
              },
              itemCount: _lists.length,
              pagination: new SwiperPagination(),
              // viewportFraction: 0.8,
              // scale: 0.9,
            ),
          ),
        );  
      },
    );
  }

  /**
   * 加载动画
   */
  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  /**
   * 顶部操作栏
   */
  Widget _topIconActions() {
    /**
     * 操作栏
     */
    List<Map> actions = [
      {
        "icon": Icon(CupertinoIcons.search),
        "key": "saerch", // 搜索
      },
      {
        "icon": Icon(CupertinoIcons.bus),
        "key": "scan", // 扫描二维码
      },
      {
        "icon": Icon(CupertinoIcons.news_solid),
        "key": "", // 签到
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