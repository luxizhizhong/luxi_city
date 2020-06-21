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