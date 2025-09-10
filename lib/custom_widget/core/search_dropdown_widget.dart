import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/font_utility.dart';

class SearchDropdownWidget extends StatelessWidget {
  final TextEditingController? controller;
  final bool? isRequired;
  final String hintText;
  final TextStyle? hintTextStyle;
  final String? initialValue;
  final bool filled;

  final void Function(dynamic)? onValueSelect;
  final void Function() onTap;
  final EdgeInsetsGeometry padding;
  final Color? iconColor;
  final Color? borderColor;
  final Widget? icon;

  const SearchDropdownWidget({
    super.key,
    this.controller,
    this.isRequired = false,
    this.hintText = "Search",
    this.hintTextStyle,
    this.onValueSelect,
    required this.onTap,
    this.padding = const EdgeInsets.all(0),
    this.iconColor,
    this.borderColor,
    this.icon,
    this.initialValue,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    print("I MA BUILDING NOW::::::: $initialValue");
    return Padding(
      padding: padding,
      child: TextFormField(
        initialValue: initialValue,
        readOnly: true,
        controller: controller,
        onTap: onTap,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled: filled,
          hintText: hintText,
          hintStyle: hintTextStyle ?? StyleUtility.hintTextStyle,
          suffixIcon:
              icon ??
              Icon(Icons.search, color: iconColor ?? AppColors.appBorderColor),
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: borderColor ?? AppColors.appBorderColor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
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
        ),
        onChanged: (value) {
          if (value.trim().isNotEmpty) {
            //  _checkIsSubmitEnable();
          }
        },
        autovalidateMode: AutovalidateMode.disabled,
        validator:
            isRequired!
                ? (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }
                  return null;
                }
                : null,
      ),
    );
  }
}
