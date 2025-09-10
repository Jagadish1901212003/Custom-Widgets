import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/font_utility.dart';
import 'package:custom_widgets/utility/toast_utility.dart';

class TextFieldNumberWidget extends StatelessWidget {
  final TextEditingController? controller;
  final bool? enabled;
  final bool isVisible;
  final TextInputType? keyboardType;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;
  final TextStyle? hintStyle;
  final double borderRadius;
  final int maxLength;
  final bool showCounterText;
  final String? counterText;
  final TextStyle? counterStyle;
  final Color? cursorColor;
  final bool? showCursor;
  final bool obscureText;
  final InputDecoration? decoration;
  final void Function(dynamic) onChange;
  final String? initialValue;
  final String? errorText;
  final String? hintText;

  const TextFieldNumberWidget({
    super.key,
    this.controller,
    this.enabled = true,
    this.isVisible = true,
    this.keyboardType,
    this.borderColor,
    this.padding = const EdgeInsets.all(0),
    this.hintStyle,
    this.borderRadius = 5,
    this.maxLength = 1000,
    this.showCounterText = false,
    this.counterText,
    this.counterStyle,
    this.cursorColor,
    this.showCursor,
    this.obscureText = false,
    this.decoration,
    required this.onChange,
    this.initialValue,
    this.errorText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    bool counterTextVisible = controller != null ? false : showCounterText;
    return isVisible
        ? Padding(
          padding: padding,
          child: TextFormField(
            initialValue: initialValue,
            cursorColor: cursorColor,
            showCursor: showCursor,
            obscureText: obscureText,
            enabled: enabled,
            controller: controller,
            maxLength: maxLength,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: false,
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*')),
            ],
            decoration:
                decoration ??
                InputDecoration(
                  filled: !enabled!,
                  fillColor:
                      borderColor?.withValues(alpha: 0.4) ??
                      AppColors.appBorderColor.withValues(alpha: 0.4),
                  hintText: hintText ?? "Maximum character limit is $maxLength",
                  errorText: errorText,
                  hintStyle: hintStyle ?? StyleUtility.hintTextStyle,
                  counterText:
                      counterTextVisible
                          ? counterText ??
                              "${maxLength - controller!.text.length} characters remaining."
                          : "",
                  counterStyle:
                      counterStyle ??
                      TextStyle(
                        fontFamily: 'Roboto',
                        color: borderColor?.withValues(alpha: 0.4),
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: borderColor ?? AppColors.appBorderColor,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: borderColor ?? AppColors.appBorderColor,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? AppColors.appBorderColor,
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: AppColors.appErrorRed,
                      width: 1,
                    ),
                  ),
                ),

            // validator: (value) {
            //   if ((value == null || value.isEmpty)) {
            //     return "this_field_is_requied_please_enter_the_value".tr();
            //   }
            //   return null;
            // },
            onChanged: (value) {
              if (maxLength == value.length) {
                ToastUtility.showErrorMessageFlushBar(
                  'Maxlength reached!',
                  context,
                );
              }
              //  print("Text field Widget onchange value is :::: $value");
              onChange(value);
            },
          ),
        )
        : const SizedBox();
  }
}
