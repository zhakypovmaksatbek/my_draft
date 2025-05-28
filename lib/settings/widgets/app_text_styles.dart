import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle header(BuildContext context) => Theme.of(
    context,
  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 18);

  static TextStyle title(BuildContext context) => Theme.of(
    context,
  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600);

  static TextStyle title20(BuildContext context) => Theme.of(
    context,
  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 20);

  static TextStyle title24(BuildContext context) => Theme.of(context)
      .textTheme
      .headlineMedium!
      .copyWith(fontWeight: FontWeight.w600, fontSize: 24);

  static TextStyle body(BuildContext context) => Theme.of(
    context,
  ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400);

  static TextStyle subtitle(BuildContext context) => Theme.of(
    context,
  ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w400);

  static TextStyle description(BuildContext context) => Theme.of(
    context,
  ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400);

  static TextStyle mini(BuildContext context) => Theme.of(
    context,
  ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400, fontSize: 11);
}
