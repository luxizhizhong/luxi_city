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
      String color,
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