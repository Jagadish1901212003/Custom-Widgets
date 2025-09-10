import 'package:flutter/material.dart';
// import 'package:incident_demo_app/utility/app_colors.dart';
import 'package:custom_widgets/utility/app_colors.dart';

class ButtonWidget {
  static Widget buttonElevated({
    required String lable,
    Color? buttonColor,
    Color? lableColor,
    TextStyle? lableStyle,
    double? borderRadius,
    Size? buttonSize,
    EdgeInsetsGeometry? margin,
    required void Function() buttonCallback,
  }) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          backgroundColor: buttonColor ?? AppColors.appPrimaryColor,
          minimumSize: buttonSize ?? const Size(100, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
          ),
        ),
        onPressed: () async {
          buttonCallback();
        },
        child: Text(
          lable,
          style:
              lableStyle ??
              TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: lableColor ?? AppColors.appWhite,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  static Widget buttonElevatedIcon({
    required String lable,
    Color? buttonColor,
    Color? lableColor,
    TextStyle? lableStyle,
    double? borderRadius,
    Size? buttonSize,
    // EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    // IconAlignment? iconAlignment,
    Widget? icon,
    required void Function() buttonCallback,
  }) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: padding ?? const EdgeInsets.all(0),
          backgroundColor: buttonColor ?? AppColors.appPrimaryColor,
          minimumSize: buttonSize ?? const Size(100, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
          ),
        ),
        onPressed: () async {
          buttonCallback();
        },
        icon: icon ?? const SizedBox(),
        // iconAlignment: iconAlignment ?? IconAlignment.start,
        label: Text(
          lable,
          style:
              lableStyle ??
              TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: lableColor ?? AppColors.appWhite,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  static Widget buttonOutline({
    required String lable,
    Color? backgroundColor,
    Color? borderColor,
    Color? lableColor,
    TextStyle? lableStyle,
    double? borderRadius,
    Size? buttonSize,
    EdgeInsetsGeometry? margin,
    required void Function() buttonCallback,
  }) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          backgroundColor: backgroundColor ?? AppColors.appWhite,
          minimumSize: buttonSize ?? const Size(100, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 5.0),
          ),
          side: BorderSide(color: borderColor ?? AppColors.appPrimaryColor),
        ),
        onPressed: buttonCallback,
        child: Text(
          lable,
          style:
              lableStyle ??
              TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: lableColor ?? AppColors.appPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  static Widget buttonOutlineIcon({
    required String lable,
    Color? backgroundColor,
    Color? borderColor,
    Color? lableColor,
    TextStyle? lableStyle,
    double? borderRadius,
    Size? buttonSize,
    EdgeInsetsGeometry? margin,
    //  IconAlignment? iconAlignment,
    Widget? icon,
    required void Function() buttonCallback,
  }) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(0),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.appWhite,
          minimumSize: buttonSize ?? const Size(100, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 5.0),
          ),
          side: BorderSide(color: borderColor ?? AppColors.appPrimaryColor),
        ),
        icon: icon ?? const SizedBox(),
        // iconAlignment: iconAlignment ?? IconAlignment.start,
        onPressed: buttonCallback,
        label: Text(
          lable,
          style:
              lableStyle ??
              TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: lableColor ?? AppColors.appPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  static Widget buttonText({
    required String lable,
    Color? lableColor,
    TextStyle? lableStyle,
    EdgeInsetsGeometry? margin,
    required void Function() buttonCallback,
  }) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(0),
      child: TextButton(
        onPressed: () async {
          buttonCallback();
        },
        child: Text(
          lable,
          style:
              lableStyle ??
              TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: lableColor ?? AppColors.appPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  static Widget buttonTextIcon({
    required String lable,
    Color? lableColor,
    TextStyle? lableStyle,
    EdgeInsetsGeometry? margin,
    //    IconAlignment? iconAlignment,
    Widget? icon,
    required void Function() buttonCallback,
  }) {
    return Padding(
      padding: margin ?? const EdgeInsets.only(right: 5),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          minimumSize: Size(80, 35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppColors.appWhite),
          ),
        ),
        onPressed: () async {
          buttonCallback();
        },

        icon: icon ?? const SizedBox(),
        // iconAlignment: iconAlignment ?? IconAlignment.start,
        label: Text(
          lable,
          style:
              lableStyle ??
              TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: lableColor ?? AppColors.appPrimaryColor,
                fontWeight: FontWeight.normal,
              ),
        ),
      ),
    );
  }

  static Widget buttonIcon({
    required Widget icon,
    Color? iconColor,
    EdgeInsetsGeometry? margin,
    AlignmentGeometry? iconAlignment,
    double? iconSize,
    required void Function() buttonCallback,
  }) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(0),
      child: IconButton(
        onPressed: buttonCallback,
        icon: icon,
        iconSize: iconSize,
        alignment: iconAlignment,
        color: iconColor ?? AppColors.appPrimaryColor,
      ),
    );
  }
}
