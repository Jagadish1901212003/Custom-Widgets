import 'package:custom_widgets/utility/app_colors.dart';
import 'package:flutter/material.dart';

class StyleUtility {
  static const TextStyle appBarTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    color: AppColors.appTextIconColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle labelTextStyle = TextStyle(
    fontFamily: 'Roboto',
    color: AppColors.appBlack,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle hintTextStyle = TextStyle(
    fontFamily: 'Roboto',
    color: AppColors.appBorderColor,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle dropDownItemTextStyle(bool selected) => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 13,
    color: selected ? AppColors.appPrimaryColor : AppColors.appBlack,
    fontWeight: selected ? FontWeight.bold : FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  static const TextStyle dropDownSelectedItemTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    color: AppColors.appBlack,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );
}
