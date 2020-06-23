/**
 * author d1y<chenhonzhou@gmail.com>
 */
import 'package:flutter/material.dart';

/**
 * 标题线条
 */
class TtitleLine {

  /**
   * 基础线条
   * color: 颜色
   * width: 宽度
   * height: 高度
   */
  static Widget Base({
      Color color,
      double width,
      double height
    }) {
    Color _c = color != null ? color : Colors.pink;
    double _w = width != null ? width : 8;
    double _h = height != null ? height : 24;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: _w,
        height: _h,
        decoration: BoxDecoration(
          color: _c
        ),
      ),
    );
  }
}

class Bar {
  static Widget Base({
    String title,
    String subTitle,
    Color barColor,
    Widget right,
  }) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 2.4,
                right: 8.2
              ),
              child: TtitleLine.Base(
                color: barColor,
                width: 5,
                height: 18
              )
            ),
            RichText(
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: title,
                    style: TextStyle(
                      color: Colors.black
                    )
                  ),
                  TextSpan(
                    text: subTitle != null ? subTitle : "",
                    style: TextStyle(
                      fontSize: 12,
                      color : Colors.grey[500]
                    )
                  )
                ]
              )
            )
          ]
        ),
        right != null ? right : Text("")
      ],
    );
  }
}