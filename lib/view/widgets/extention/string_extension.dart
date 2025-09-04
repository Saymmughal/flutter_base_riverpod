import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/utils/app_styles/style.dart';
import 'package:flutter_base_riverpod/utils/font_scaling_manager.dart';

extension StringExtension on String {
  Widget toText({
    Color? color,
    double? fontSize,
    int? maxLine,
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    Color? backgroundColor,
    double? lineHeight,
  }) => Text(
    this,
    maxLines: maxLine ?? maxLine,
    textAlign: textAlign ?? textAlign,
    style: TextStyle(
      height: lineHeight,
      backgroundColor: backgroundColor,
      color: color,
      fontSize: FontScalingManager.instance.getScaledFontSize(fontSize ?? 12),
      fontWeight: fontWeight ?? AppStyle.w400, // By Default Regular Font
      overflow: overflow ?? TextOverflow.ellipsis,
    ),
  );
}
