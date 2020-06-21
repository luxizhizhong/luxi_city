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
}