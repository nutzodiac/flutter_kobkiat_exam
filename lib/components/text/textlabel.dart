import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../helper/scale_size.dart';
import '../../utils/colors.dart';

class MyTextlabel extends StatelessWidget {
  String? semanticslabel;
  final String text;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  Color? color;
  final TextDecoration? decoration;
  int? maxline;
  double? fontSize;
  TextStyle? textStyle;

  //#region SizeText
  MyTextlabel.sizeSS({
    this.semanticslabel,
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.color,
    this.decoration = TextDecoration.none,
    this.maxline = 1,
    this.fontSize,
    super.key
  }) {
    textAlign = textAlign ?? TextAlign.left;
    fontWeight = fontWeight ?? FontWeight.w400;
    color = color ?? MyColors.black78;
    maxline = maxline;
    fontSize = fontSize ?? 15;
  }

  MyTextlabel.sizeS({
    this.semanticslabel,
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.color,
    this.decoration = TextDecoration.none,
    this.maxline = 1,
    this.fontSize,
    super.key
  }) {
    textAlign = textAlign ?? TextAlign.left;
    fontWeight = fontWeight ?? FontWeight.w400;
    color = color ?? MyColors.black78;
    maxline = maxline;
    fontSize = fontSize ?? 16;
  }

  MyTextlabel.sizeM({
    this.semanticslabel,
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.color,
    this.decoration = TextDecoration.none,
    this.maxline = 1,
    this.fontSize,
    super.key
  }) {
    textAlign = textAlign ?? TextAlign.left;
    fontWeight = fontWeight ?? FontWeight.w500;
    color = color ?? MyColors.black78;
    maxline = maxline;
    fontSize = fontSize ?? 17;
  }

  MyTextlabel.sizeL({
    this.semanticslabel,
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.color,
    this.decoration = TextDecoration.none,
    this.maxline = 1,
    this.fontSize,
    super.key
  }) {
    textAlign = textAlign ?? TextAlign.left;
    fontWeight = fontWeight ?? FontWeight.w600;
    color = color ?? MyColors.black78;
    maxline = maxline;
    fontSize = fontSize ?? 18;
  }

  MyTextlabel.sizeXL({
    this.semanticslabel,
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.color,
    this.decoration = TextDecoration.none,
    this.maxline = 1,
    this.fontSize,
    super.key
  }) {
    textAlign = textAlign ?? TextAlign.left;
    fontWeight = fontWeight ?? FontWeight.w400;
    color = color ?? MyColors.black78;
    maxline = maxline;
    fontSize = fontSize ?? 24;
  }

  MyTextlabel.sizeXXL({
    this.semanticslabel,
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.color,
    this.decoration = TextDecoration.none,
    this.maxline = 1,
    this.fontSize,
    super.key
  }) {
    textAlign = textAlign ?? TextAlign.left;
    fontWeight = fontWeight ?? FontWeight.w400;
    color = color ?? MyColors.black78;
    maxline = maxline;
    fontSize = fontSize ?? 36;
  }

  MyTextlabel.sizeXXXL({
    this.semanticslabel,
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.color,
    this.decoration = TextDecoration.none,
    this.maxline = 1,
    this.fontSize,
    super.key
  }) {
    textAlign = textAlign ?? TextAlign.left;
    fontWeight = fontWeight ?? FontWeight.w400;
    color = color ?? MyColors.black78;
    maxline = maxline;
    fontSize = fontSize ?? 40;
  }

  //#endregion

  MyTextlabel.custom({
    this.semanticslabel,
    required this.text,
    this.textAlign = TextAlign.left,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.decoration = TextDecoration.none,
    this.maxline = 1,
    this.fontSize = 15,
    this.textStyle,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      identifier: semanticslabel ?? '',
      label: semanticslabel ?? '',
      container: true,
      child: AutoSizeText(
        semanticsLabel: '',
        text,
        maxLines: maxline,
        minFontSize: 14,
        textAlign: textAlign,
        style: textStyle ?? TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color ?? MyColors.black78, decoration: decoration, fontFamily: "Asap"),
        textScaleFactor: ScaleSize.textScaleFactor(context),
        overflow: maxline == null ? null : TextOverflow.ellipsis,
        softWrap: maxline == null ? true : false
      ),
    );
  }
}