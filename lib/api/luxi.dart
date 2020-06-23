import 'dart:convert';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:luxi_city/config/const.dart';
import 'package:luxi_city/utils/ins.dart';
import 'package:luxi_city/utils/share.dart';

class LuxiCityApi {
  /**
   * 获取首页 `banner` 图片
   */
  static Future<List<Map>> getHomeBanners() async {
    try {
      /**
       * 未知属性, 估计是用来坑钱的(判断id那不就是咯!)
       * 既然要追求刺激, 那就贯彻到底咯!
       */
      FormData formData = FormData.fromMap({
        "type": "index",
        "accid": ConstKey.apiID,
      });
      Response response = await dio.post("/adsinfo.php", data: formData);
      String _ctx = response.data;
      Map<String, dynamic> _data = jsonDecode(_ctx);
      Map<String, dynamic> _info = _data['info'];
      List<Map> _lists = [];
      _info.forEach((key, value) {
        _lists.add(value);
      });
      return _lists;
    } catch(err) {
      throw new Exception("请求失败");
    }
  }

  /**
   * 获取首页的菜单
   */
  static Future<List<Map>> getHomeMenus() async {
    try {
      Response res = await dio.get("https://91tcw.cc/data/js/menus_${ ConstKey.apiID }.js");
      String _ctx = res.data.trim();
      _ctx = _ctx.replaceAll("'", "\"");
      PoiHttpShareUtils Yoli = new PoiHttpShareUtils();
      Yoli.setContent(_ctx);
      return Yoli.toDartList();
    } catch (e) {
      throw new Exception("请求失败");
    }
  }

  /**
   * 一言api
   */
  static Future<Map> getYoli() async {
    Map _result = {
      "content": "", // 内容
      "author": "", // 作者
    };
    try {
      Response res = await dio.get("https://v1.hitokoto.cn/?encode=json");
      Map _data = res.data;
      _result['content'] = _data['hitokoto'];
      _result['author'] = _data['from'];
    } catch (err) {
      _result['content'] = "打工是不可能打工的";
      _result['author'] = "陈某";
    }
    return _result;
  }

  /// 获取商店
  static Future<List> getStores({ int page = 0 }) async {
    FormData formData = FormData.fromMap({
      "page": page,
      "ajax": "Y",
      "accid": ConstKey.apiID,
      "do": "lists",
      "lng": null,
      "lat": null,
      "none": 1,
      "screen": 0
    });
    Response res = await dio.post("/per_index.php", data: formData);
    String data = res.data;
    Map _data = jsonDecode(data);
    List shopList = _data['shop_list'];
    return shopList;
  }

}