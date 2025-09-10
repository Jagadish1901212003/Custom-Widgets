import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/custom_widget/core/buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtility {
  static showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.appGreen,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.appErrorRed,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static showErrorMessageFlushBar(
    String message,
    BuildContext context, {
    FlushbarPosition? position,
  }) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        flushbarPosition: position ?? FlushbarPosition.BOTTOM,
        message: message,
        duration: const Duration(seconds: 3),
        backgroundColor: AppColors.appErrorRed,
        reverseAnimationCurve: Curves.easeOut,
        forwardAnimationCurve: Curves.decelerate,
        icon: const Icon(Icons.error, color: AppColors.appWhite),
      )..show(context),
    );
  }

  static showSuccessMessageFlushBar(
    String message,
    BuildContext context, {
    FlushbarPosition? position,
  }) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        flushbarPosition: position ?? FlushbarPosition.BOTTOM,
        message: message,
        duration: const Duration(seconds: 3),
        backgroundColor: AppColors.appGreen,
        reverseAnimationCurve: Curves.easeOut,
        forwardAnimationCurve: Curves.decelerate,
        icon: const Icon(Icons.check_circle, color: AppColors.appWhite),
      )..show(context),
    );
  }

  static showDataUpdateMessage({
    required Future<void> Function() onSync,
    required Future<void> Function() onCancel,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: AppColors.appLightPrimaryColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "You have data to sync!",
            style: TextStyle(
              fontFamily: 'Roboto',
              color: AppColors.appBlack,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              // fontStyle: FontStyle.normal,
            ),
          ),
          ButtonWidget.buttonElevated(
            margin: const EdgeInsets.all(0),
            buttonSize: const Size(70, 35),
            lable: 'Sync',
            lableStyle: const TextStyle(
              fontFamily: 'Roboto',
              color: AppColors.appWhite,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              // fontStyle: FontStyle.normal,
            ),
            buttonCallback: onSync,
          ),
          GestureDetector(
            onTap: onCancel,
            child: Icon(Icons.close, color: AppColors.appPrimaryColor),

            // Image.asset(
            //   "assets/images/ic_close_blue.png",
            //   width: 16,
            //   height: 16,
            //   color: AppColors.appPrimaryColor,
            // ),
          ),
        ],
      ),
    );
  }
}
