import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility//font_utility.dart';
import 'package:custom_widgets/utility//pop_up_dialog_utility.dart';

class FieldLableWidget extends StatelessWidget {
  final String lable;
  final bool isRequired;
  final TextStyle? textStyle;
  final TextStyle? starTextStyle;
  final EdgeInsetsGeometry padding;
  final bool? visibleHelperIcon;
  final String? helperText;
  const FieldLableWidget({
    super.key,
    required this.lable,
    this.isRequired = false,
    this.textStyle,
    this.starTextStyle,
    this.padding = const EdgeInsets.only(top: 10, bottom: 4),
    this.visibleHelperIcon = false,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return visibleHelperIcon!
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  child: RichText(
                    text: TextSpan(
                      text: lable,
                      style: textStyle ?? StyleUtility.labelTextStyle,
                      children: isRequired == true
                          ? [
                              TextSpan(
                                text: ' *',
                                style:
                                    starTextStyle ??
                                    const TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                              ),
                            ]
                          : [],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  PopUpDialogUtility.showAlertDialogSystem(
                    context: context,
                    popupTitle: 'Instructions',
                    description: helperText ?? "",
                  );
                },
                // icon of the button
                style: ElevatedButton.styleFrom(
                  //alignment: Alignment.topCenter,
                  minimumSize: Size(15, 15),
                  // styling the button
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(2),
                  backgroundColor: AppColors.appPrimaryColor, // Button color
                ),
                child: Icon(
                  Icons.question_mark,
                  size: 15,
                  color: AppColors.appWhite,
                ),
              ),
            ],
          )
        : Padding(
            padding: padding,
            child: RichText(
              text: TextSpan(
                text: lable,
                style: textStyle ?? StyleUtility.labelTextStyle,
                children: isRequired == true
                    ? [
                        TextSpan(
                          text: ' *',
                          style:
                              starTextStyle ??
                              const TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.red,
                                fontSize: 12,
                              ),
                        ),
                      ]
                    : [],
              ),
            ),
          );
  }
}
