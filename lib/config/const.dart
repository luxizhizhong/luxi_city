/**
 * author d1y<chenhonzhou@gmail.com>
 */

import 'package:flutter/cupertino.dart';

/**
 * 首页底部菜单
 */
List<Map> bottomMenusBar = [
  {
    "title": "首页",
    "icon": CupertinoIcons.home
  },
  {
     "title": "本地商城",
     "icon": CupertinoIcons.location
  },
  {
    "title": "本地信息",
    "icon": CupertinoIcons.bookmark
  },
  {
    "title": "个人中心",
    "icon": CupertinoIcons.person
  }
];

/**
 * 常量 `key`
 */
class ConstKey {
  static const title = '泸溪同城';
  /**
   * 基础接口
   */
  static const baseURL = 'http://a.ffiabg.top/wweb_8';

  /**
   * 未知的接口id
   */
  static const apiID = 76;
}

/*
爬自: http://a.ffiabg.top/wweb_8/index.php?accid=76&chanceapp=1
Array.from($('.wideclick')).map(item=> {
  let icon = $(item).find('img')[0].src
  let title = $(item).find('h3').text()
  let subTitle = $(item).find('p').text()
  return {
    icon,
    title,
    subTitle
  }
})
首页城市信息列表
*/
List<Map> PlateGridViewList = [
  {
    "icon": "https://91tcw.cc/images/service/sv_7.png",
    "title": "二手市场",
    "subTitle": "优质好货便宜实用"
  },
  {
    "icon": "https://91tcw.cc/images/service/sv_12.png",
    "title": "房屋出租",
    "subTitle": "海量房源信息"
  },
  {
    "icon": "https://91tcw.cc/images/service/sv_8.png",
    "title": "房屋出售",
    "subTitle": "网上看房沟通方便"
  },
  {
    "icon": "https://91tcw.cc/upload4/76/indexcontent8/1566645020064589-6635.png",
    "title": "生意/店面转让",
    "subTitle": "马上做老板"
  }
];