
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:frefresh/frefresh.dart';
import 'package:luxi_city/api/luxi.dart';
import 'package:luxi_city/config/const.dart';
import 'package:list_ext/list_ext.dart';
import 'package:luxi_city/widget/widget.dart';
import 'package:rating_bar/rating_bar.dart';

class AppHomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppHomeViewState();
  }

}

class AppHomeViewState extends State<AppHomeView> {

  /// 分页
  int _page = 0;
  /// 商店
  List _stores = [];

  void getStoreLists() async {
    List _list = await LuxiCityApi.getStores(page: _page);
    List _newList = _stores.copyWithAll(_list);
    setState(() {
      _stores = _newList;
    });
  }

  @override initState() {
    getStoreLists();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        child: FRefresh(
          /// 设置控制器
          controller: controller,
          /// 需要传入 Header 区域大小
          headerHeight: 75.0,
          /// 构建刷新 Header
          headerBuilder: (setter, constraints) {
            return Container(
              child: Center(
                child: _loading(),
              ),
            );
          },
          /// 内容区域 Widget
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              _banner(),
              _menus(),
              _ads(),
              _plate(),
              _store(),
            ],
          ),
          /// 进入 Refreshing 后会回调该函数
          onRefresh: () {
            /// 通过 controller 结束刷新
            controller.finishRefresh();
          },
        ),
        // child: ListView(
        //   children: <Widget>[
        //     _banner(),
        //     _menus(),
        //     _ads(),
        //     _plate(),
        //   ],
        // )
      )
    );
  }

  /**
   * 推荐商家
   */
  Widget _store() {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.only(
        top: 8,
        bottom: 8
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Bar.Base(
            title: "推荐商家",
            barColor: Colors.yellow
          ),
          Column(
            children: _stores.map((item) {
              return _storeItem(item);
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _storeItem(Map item) {
    // String _tips = "您当前的位置不在商家配送范围内";

    /// 这里是真的恶心, 忽略这里的代码
    // int _py = item['shipping_cut'];
    // var Fuck = item['shipping_fee'];
    // bool _pyFlag = _py == Fuck;
    // var _resPy = _py.toStringAsFixed(2); /// kill the line
    /// 求求后台不要写前端行不行..
    
    return Container(
      margin: EdgeInsets.only(
        top: 2.4,
        bottom: 2.4
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Colors.grey[300]
          )
        )
      ),
      child: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                // height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        item['picture'],
                        width: 62,
                        height: 62,
                        fit:BoxFit.fill,
                        errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                          return Container(
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 0, 0, .4),
                            ),
                            // child: Center(
                            //   child: Text("加载失败"),
                            // ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 5.2,
                        left: 12
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 4
                            ),
                            child: Text(
                              item['name'],
                              style: TextStyle(
                                color: Colors.black87
                              )
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              RatingBar.readOnly(
                                filledColor: Colors.yellow,
                                initialRating: 3.5,
                                isHalfAllowed: true,
                                halfFilledIcon: Icons.star_half,
                                filledIcon: Icons.star,
                                emptyIcon: Icons.star_border,
                                size: 22,
                              ),
                              Text("销量:${ item['goods_count'] }")
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 4,
                              bottom: 4
                            ),
                            /// 这里不知道为什么要这么设计
                            /// 以前的单价 - 当前的单价(应该是这样的)
                            /// shipping_fee: 3 - shipping_cut: "3"
                            /// 猜测就是为了拿到浮点数..
                            /// 我通过看混淆后的代码还是没看懂这里的逻辑
                            /// 有一点点无语 - 陈某 <chenhonzhou@gmail.com>
                            child: RichText(
                              text: TextSpan(
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: "起送￥${ item['least_money'] }",
                                    style: TextStyle(
                                      color: Colors.black54
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        right: 4,
                                        left: 4
                                      ),
                                      child: Text("|"),
                                    ),
                                    style: TextStyle(
                                      color: Colors.black54
                                    )
                                  ),
                                  TextSpan(
                                    text:  false ? "免配送费" : '配送费￥${ item['shipping_fee'] }',
                                    style: TextStyle(
                                      color: Colors.black54
                                    ),
                                  ),
                                ]
                              ),
                              
                            ),
                          ),
                        ]
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "${ item['transit_time'] }分钟"
              ),
            ],
          ),
          // TODO, 不知道这里的判断条件是什么
          // Text(
          //   _tips,
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 12,
          //     color: Colors.red
          //   )
          // )
        ],
      )
    );
  }

  /**
   * appbar
   */
  Widget _appBar() {
    return AppBar(
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
    );
  }

  /**
   * 同城服务标题
   */
  Widget _plateTitle() {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        // color: Colors.red
      ),
      child: Bar.Base(
        title: "城市信息",
        subTitle: "全城信息发布中心",
        barColor: Colors.pink,
        right: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "更多",
              style: TextStyle(
                fontSize: 12,
                color : Colors.grey[500]
              )
            ),
            Icon(
              Icons.navigate_next,
              color : Colors.grey[500]
            )
          ],
        )
      )
    );
  }

  // FLag: 只能用 `50%` 来算..
  Widget _plateGrid(double _w) {
    // 间隙
    double _sp = 2.4;
    return Wrap(
      spacing: _sp,
      children: PlateGridViewList.map((Map item){
        return _plateGridItem(
          item: item,
          w: _w,
          sp: _sp
        );
      }).toList(),
    );
  }

  /**
   * 城市信息单列
   * item: 单列数据
   * w: 设置到的高度
   * sp: 设置的间隙
   */
  Widget _plateGridItem({Map item, double w, double sp}) {
    return Container(
      width: (w / 2) - (sp * 2),
      height: 42,
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.only(
        bottom: 12
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[200]
          ),
          right: BorderSide(
            color: Colors.grey[200]
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    bottom: 4
                  ),
                  child: Text(
                    item['title'],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87
                    ),
                  ),
                ),
                Text(
                  item['subTitle'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500]
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Image.network(
              item['icon'],
              width: 38,
              height: 38,
            ),
          )
        ],
      ),
    );
  }

  /**
   * 同城服务
   */
  Widget _plate() {
    return Container(
      width: ScreenUtil.screenWidth,
      // height: ScreenUtil().setHeight(460),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey[300]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          // padding: EdgeInsets.all(3.44),
          child: LayoutBuilder(
            builder: (ctx, _c) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _plateTitle(),
                  _plateGrid(_c.maxWidth)
                ],
              );
            },
          )
        ),
      )
    );
  }

  /**
   * 这里是广告位
   */
  Widget _ads() {
    return FutureBuilder(
      future: LuxiCityApi.getYoli(),
      builder: (context, snapshot) {
        Map data = snapshot.data;
        return Container(
          width: ScreenUtil.screenWidth,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.pink
          ),
          child: Center(
            child: RichText(
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: data['content'],
                  ),
                ]
              ),
            ),
          ),
        );
      },
    );
  }

  /**
   * 菜单
   */
  Widget _menus() {
    return FutureBuilder(
      future: LuxiCityApi.getHomeMenus(),
      builder: (context, snapshot) {

        List<Map> lists = snapshot.data;
        // 最大高度
        int maxCol = 3;
        // 一列的长度
        int widthCol = 5;
        // 当前总长度
        // int totalCol = lists.length;
        // 换算的长度
        int Col = maxCol * widthCol;
        List ChunksList = lists.chunks(Col).toList();

        Widget _render;

        if (ChunksList.length >= 2) {
          _render = Swiper(
            itemBuilder: (BuildContext context, int index) {
              List ele = ChunksList[index];
              List<Widget> _lists = ele.map((item) {
                return _menuItem(item);
              }).toList();
              return GridView.count(
                crossAxisCount: 5,
                children: _lists,
                shrinkWrap: true,
              );
            },
            itemCount: ChunksList.length,
            pagination: new SwiperPagination(),
          );
        } else {
          List<Widget> _lists = lists.map((item) {
            return _menuItem(item);
          }).toList();
          _render = GridView.count(
            crossAxisCount: 5,
            children: _lists,
            shrinkWrap: true,
          );
        }

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
          child: _render,
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
          backgroundColor: Colors.white,
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
          width: ScreenUtil.screenWidth,
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

FRefreshController controller = FRefreshController();