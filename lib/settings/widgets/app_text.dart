//ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:draft/settings/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';

enum TextType {
  header,
  body,
  title,
  subtitle,
  description,
  title20,
  title24,
  mini,
}

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    this.fontWeight,
    required this.title,
    this.maxLines,
    this.color,
    this.overflow,
    this.textAlign,
    required this.textType,
    this.textDirection,
    this.decoration,
    this.decorationColor,
  });

  final FontWeight? fontWeight;
  final String title;
  final int? maxLines;
  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextType textType;
  final TextDirection? textDirection;
  final TextDecoration? decoration;
  final Color? decorationColor;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = getTextStyle(textType, context);

    if (fontWeight != null) {
      textStyle = textStyle.copyWith(fontWeight: fontWeight);
    }

    Color? textColor = color ?? textStyle.color;

    return Text(
      title,
      overflow: overflow,
      maxLines: maxLines,
      textDirection: textDirection,
      textAlign: textAlign ?? TextAlign.start,

      style: textStyle.copyWith(
        color: textColor,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: decorationColor ?? Colors.grey,
      ),
    );
  }

  TextStyle getTextStyle(TextType type, BuildContext context) {
    switch (type) {
      case TextType.header:
        return AppTextStyles.header(context);
      case TextType.body:
        return AppTextStyles.body(context);
      case TextType.title:
        return AppTextStyles.title(context);
      case TextType.title20:
        return AppTextStyles.title20(context);
      case TextType.title24:
        return AppTextStyles.title24(context);
      case TextType.subtitle:
        return AppTextStyles.subtitle(context);
      case TextType.description:
        return AppTextStyles.description(context);
      case TextType.mini:
        return AppTextStyles.mini(context);
    }
  }
}
