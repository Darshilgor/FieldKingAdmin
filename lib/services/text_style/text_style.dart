import 'package:flutter/material.dart';

class Constant {
  static const String FontFamily = "Lato";
}

extension TextStyleExtensions on TextStyle {
  TextStyle get black16 => customStyle(
        letterSpacing: 0.0,
        fontSize: 16,
        weight: FontWeight.w900,
      );

  TextStyle get heavy16 => customStyle(
        letterSpacing: 0.0,
        fontSize: 16,
        weight: FontWeight.w800,
      );
  TextStyle get heavy20 => customStyle(
        letterSpacing: 0.0,
        fontSize: 20,
        weight: FontWeight.w800,
      );

  TextStyle get bold16 => customStyle(
        letterSpacing: 0.0,
        fontSize: 16,
        weight: FontWeight.w700,
      );

  TextStyle get bold18 => customStyle(
        letterSpacing: 0.0,
        fontSize: 18,
        weight: FontWeight.w700,
      );

  TextStyle get semiBold16 => customStyle(
        letterSpacing: 0.0,
        fontSize: 16,
        weight: FontWeight.w600,
      );

  TextStyle get semiBold11 => customStyle(
        letterSpacing: 0.0,
        fontSize: 11,
        weight: FontWeight.w600,
      );

  TextStyle get semiBold12 => customStyle(
        letterSpacing: 0.0,
        fontSize: 12,
        weight: FontWeight.w600,
      );

  TextStyle get semiBold14 => customStyle(
        letterSpacing: 0.0,
        fontSize: 14,
        weight: FontWeight.w600,
      );

  TextStyle get medium16 => customStyle(
        letterSpacing: 0.0,
        fontSize: 16,
        weight: FontWeight.w500,
      );

  TextStyle get medium14 => customStyle(
        letterSpacing: 0.0,
        fontSize: 14,
        weight: FontWeight.w500,
      );

  TextStyle get regular16 => customStyle(
        letterSpacing: 0.0,
        fontSize: 16,
        weight: FontWeight.w400,
      );
  TextStyle get regular18 => customStyle(
        letterSpacing: 0.0,
        fontSize: 18,
        weight: FontWeight.w400,
      );
  TextStyle get regular20 => customStyle(
        letterSpacing: 0.0,
        fontSize: 20,
        weight: FontWeight.w400,
      );
  TextStyle get regular10 => customStyle(
        letterSpacing: 0.0,
        fontSize: 10,
        weight: FontWeight.w400,
      );

  TextStyle get light16 => customStyle(
        letterSpacing: 0.0,
        fontSize: 16,
        weight: FontWeight.w300,
      );

  TextStyle get light12 => customStyle(
        letterSpacing: 0.0,
        fontSize: 12,
        weight: FontWeight.w300,
      );

  TextStyle get thin16 => customStyle(
        letterSpacing: 0.0,
        fontSize: 16,
        weight: FontWeight.w200,
      );

  /// font size 14.
  TextStyle get bold14 => customStyle(
        letterSpacing: 0.0,
        fontSize: 14,
        weight: FontWeight.w700,
      );

  TextStyle get bold26 => customStyle(
        letterSpacing: 0.0,
        fontSize: 26,
        weight: FontWeight.w700,
      );
  TextStyle get bold20 => customStyle(
        letterSpacing: 0.0,
        fontSize: 20,
        weight: FontWeight.w700,
      );

  TextStyle get regular14 => customStyle(
        letterSpacing: 0.0,
        fontSize: 14,
        weight: FontWeight.w400,
      );

  TextStyle get regular15 => customStyle(
        letterSpacing: 0.0,
        fontSize: 15,
        weight: FontWeight.w400,
      );

  /// font size 13.
  TextStyle get regular13 => customStyle(
        letterSpacing: 0.0,
        fontSize: 13,
        weight: FontWeight.w400,
      );

  TextStyle get regular11 => customStyle(
        letterSpacing: 0.0,
        fontSize: 11,
        weight: FontWeight.w400,
      );

  TextStyle get regular12 => customStyle(
        letterSpacing: 0.0,
        fontSize: 12,
        weight: FontWeight.w400,
      );

  /// font size 15.
  TextStyle get semiBold15 => customStyle(
        letterSpacing: 0.0,
        fontSize: 15,
        weight: FontWeight.w600,
      );

  /// font size 18.
  TextStyle get semiBold18 => customStyle(
        letterSpacing: 0.0,
        fontSize: 18,
        weight: FontWeight.w600,
      );

  TextStyle get semiBold17 => customStyle(
        letterSpacing: 0.0,
        fontSize: 17,
        weight: FontWeight.w600,
      );
  TextStyle get semiBold13 => customStyle(
        letterSpacing: 0.0,
        fontSize: 13,
        weight: FontWeight.w600,
      );

  /// font size 24.
  TextStyle get medium24 => customStyle(
        letterSpacing: 0.0,
        fontSize: 24,
        weight: FontWeight.w500,
      );
  TextStyle get medium20 => customStyle(
        letterSpacing: 0.0,
        fontSize: 20,
        weight: FontWeight.w500,
      );
  TextStyle get medium18 => customStyle(
        letterSpacing: 0.0,
        fontSize: 18,
        weight: FontWeight.w500,
      );

  TextStyle get medium17 => customStyle(
        letterSpacing: 0.0,
        fontSize: 17,
        weight: FontWeight.w500,
      );

  TextStyle get medium13 => customStyle(
        letterSpacing: 0.0,
        fontSize: 13,
        weight: FontWeight.w500,
      );

  TextStyle get medium12 => customStyle(
        letterSpacing: 0.0,
        fontSize: 12,
        weight: FontWeight.w500,
      );

  TextStyle get medium11 => customStyle(
        letterSpacing: 0.0,
        fontSize: 11,
        weight: FontWeight.w500,
      );

  /// text color and weight and size.

  /// font size 28.
  TextStyle get medium28 => customStyle(
        letterSpacing: 0.0,
        fontSize: 28,
        weight: FontWeight.w500,
      );

  TextStyle textColor(Color v) => copyWith(color: v);

  TextStyle weight(FontWeight v) => copyWith(fontWeight: v);

  TextStyle size(double v) => copyWith(fontSize: v);

  TextStyle letterSpace(double v) => copyWith(letterSpacing: v);

  TextStyle customStyle({
    required double letterSpacing,
    required double fontSize,
    required FontWeight weight,
  }) =>
      copyWith(
        letterSpacing: letterSpacing,
        fontSize: fontSize,
        fontWeight: weight,
        fontFamily: Constant.FontFamily,
      );
}
