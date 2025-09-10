import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/font_utility.dart';
import 'package:custom_widgets/utility/toast_utility.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final bool? enabled;
  final bool? isRequired;
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
  final int? maxLines;
  final String? hintText;

  const TextFieldWidget({
    super.key,
    this.controller,
    this.isRequired = false,
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
    this.maxLines,
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
            maxLines: maxLines,
            enabled: enabled,
            textInputAction: TextInputAction.next,
            controller: controller,
            maxLength: maxLength,
            keyboardType: keyboardType ?? TextInputType.text,
            decoration:
                decoration ??
                InputDecoration(
                  errorText: null, // don't show error text
                  errorStyle: TextStyle(height: 0, fontSize: 0),
                  isDense: true, // o
                  filled: !enabled!,
                  fillColor:
                      borderColor?.withValues(alpha: 0.4) ??
                      AppColors.appBorderColor.withValues(alpha: 0.4),
                  hintText: hintText ?? "Maximum character limit is $maxLength",
                  // errorText: errorText,
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
                    borderRadius: BorderRadius.circular(5),
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
            onChanged: (value) {
              if (maxLength == value.length) {
                ToastUtility.showErrorMessageFlushBar(
                  'Maxlength reached!',
                  context,
                );
              }

              onChange(value);
            },
            autovalidateMode: AutovalidateMode.disabled,
            validator:
                isRequired!
                    ? (value) {
                      if (value == null || value.trim().isEmpty) {
                        return '';
                      }
                      return null;
                    }
                    : null,
          ),
        )
        : const SizedBox();
  }
}
