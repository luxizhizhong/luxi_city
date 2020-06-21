/**
 * author: d1y<chenhonzhou@gmail.com>
 */


import 'dart:convert';

/**
 * `http` 中间拿到的数据的处理
 */
class PoiHttpShareUtils {

  /**
   * 丢进来的内容
   */
  String _content = "";

  /**
   * 设置内容
   */
  void setContent(String ctx) {
    _content = ctx;
  }

  /**
   * 将内容转为数组
   */
  List<Map> toDartList() {
    // TODO
    int startIndex = 'var menus = new Array'.length - 1;
    int endIndex = _content.length - 2;
    String jsonArr = _content.substring(startIndex, endIndex);
    List<String> _sp = jsonArr.split("],");
    var _res = _sp.map((item) {
      String _json = item;
      int len = item.length - 1;
      if (item[len] != ']') {
        _json = item + ']'; 
      }
      var _yxi = jsonDecode(_json);
      Map _result = {
        "title": _yxi[0],
        "img": _yxi[1],
        "href": _yxi[2],
      };
      return _result;
    }).toList();
    print(_res);
    return _res;
  }
}