import 'package:flutter/material.dart';

class AppColors {
  //#option 1
  static const appDarkPrimaryColor = Color.fromRGBO(125, 30, 24, 1);
  static const appPrimaryColor = Color.fromRGBO(125, 30, 24, 1);
  static const appLightPrimaryColor = Color.fromRGBO(183, 150, 148, 1);

  static const appSecondaryColor = Color.fromRGBO(41, 40, 36, 1);

  static const appTextIconColor = Color.fromRGBO(255, 255, 255, 1);
  static const appPrimaryTextColor = Color.fromRGBO(33, 33, 33, 1);
  static const appSecondaryTextColor = Color.fromRGBO(117, 117, 117, 1);

  //general Colors
  static const appWhite = Colors.white;
  static const appBlack = Color(0xFF000000);
  static const appGreen = Colors.green;
  static const appErrorRed = Color.fromRGBO(251, 5, 18, 1);
  static const appBorderColor = Color.fromRGBO(189, 189, 189, 1);
  static const appGreyColor = Color.fromRGBO(117, 117, 117, 1);
  static const appGrayDisable = Color.fromRGBO(137, 137, 137, 1);
}

class AppColors1 {
  // Primary brand color (your base tone, refined a bit)
  static const appPrimaryColor = Color(0xFF7D1E18); // deep red-brown

  // Secondary color (complementary – for highlights, buttons, links)
  static const appSecondaryColor = Color(0xFF1565C0); // deep professional blue

  // Accent color (for success states, highlights, active icons)
  static const appAccentColor = Color(0xFF2E7D32); // elegant green

  // Background (light mode)
  static const backgroundLight = Color(0xFFF9F9F9);

  // Background (dark mode)
  static const backgroundDark = Color(0xFF121212);

  // Surface colors (cards, dialogs, sheets)
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceDark = Color(0xFF1E1E1E);

  // Text colors
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);

  // Neutral greys (dividers, borders, disabled states)
  static const neutralGrey = Color(0xFFBDBDBD);

  // Error / Warning
  static const errorColor = Color(0xFFD32F2F);
  static const warningColor = Color(0xFFF57C00);
}
