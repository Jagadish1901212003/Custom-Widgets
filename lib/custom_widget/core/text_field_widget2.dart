import 'package:custom_widgets/custom_widget/core/field_label_widget2.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/font_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:custom_widgets_catalog/widgets/field_label_widget.dart';
// import 'package:custom_widgets_catalog/utility/font_utility.dart';
// import 'package:custom_widgets_catalog/utility/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  /// The label text shown above the text field.
  final String fieldName;

  /// Controller to manage the text being edited.
  final TextEditingController? controller;

  /// Whether the text field is enabled or disabled.
  final bool enabled;

  /// Whether the field is required (affects validation and label).
  final bool isRequired;

  /// Whether the field is visible in the UI.
  final bool isVisible;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// The color of the border around the text field.
  final Color? borderColor;

  /// Padding around the entire widget.
  final EdgeInsetsGeometry padding;

  /// Style of the hint text shown when the field is empty.
  final TextStyle? hintStyle;

  /// Radius of the border corners.
  final double borderRadius;

  /// Maximum number of characters allowed in the field.
  final int maxLength;

  /// Whether to show the counter text below the field.
  final bool showCounterText;

  /// Custom counter text to show instead of default.
  final String? counterText;

  /// Style of the counter text.
  final TextStyle? counterStyle;

  /// Color of the text cursor.
  final Color? cursorColor;

  /// Whether to show the text cursor.
  final bool? showCursor;

  /// Whether to obscure the text (for passwords).
  final bool obscureText;

  /// Custom input decoration for the text field.
  final InputDecoration? decoration;

  /// Callback function called when the text changes.
  final void Function(String) onChange;

  /// Initial value to populate the text field.
  final String? initialValue;

  /// Error text to display below the text field.
  final String? errorText;

  /// Maximum lines the text field can expand to.
  final int? maxLines;

  /// Hint text to show when the field is empty.
  final String? hintText;

  /// Validation method
  final FormFieldValidator<String>? validator;

  /// Controls when to auto-validate the input.
  final AutovalidateMode autovalidateMode;

  const TextFieldWidget({
    super.key,
    this.controller,
    required this.fieldName,
    required this.isRequired,
    this.enabled = true,
    this.isVisible = true,
    this.keyboardType,
    this.borderColor,
    this.padding = EdgeInsets.zero,
    this.hintStyle,
    this.borderRadius = 5.0,
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
    this.maxLines = 1,
    this.hintText,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
  }) : assert(
         controller == null || initialValue == null,
         'Cannot provide both a controller and an initialValue.',
       );

  @override
  Widget build(BuildContext context) {
    // Show counter only if no controller is provided and showCounterText is true
    final bool counterTextVisible = controller == null && showCounterText;

    return isVisible
        ? Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FieldLabelWidget(label: fieldName, isRequired: isRequired),
                TextFormField(
                  initialValue: controller == null ? initialValue : null,
                  controller: controller,
                  enabled: enabled,
                  keyboardType: keyboardType ?? TextInputType.text,
                  obscureText: obscureText,
                  cursorColor: cursorColor,
                  showCursor: showCursor,
                  maxLength: maxLength,
                  maxLines: maxLines,
                  textInputAction: TextInputAction.next,
                  inputFormatters:
                      keyboardType ==
                          TextInputType.numberWithOptions(
                            decimal: true,
                            signed: false,
                          )
                      ? <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+(\.\d*)?$'),
                          ),
                        ]
                      : null,
                  decoration:
                      decoration ??
                      InputDecoration(
                        isDense: true,
                        filled: !enabled,
                        fillColor: (borderColor ?? AppColors.appBorderColor)
                            .withValues(alpha: 0.4),
                        hintText:
                            hintText ?? "Maximum character limit is $maxLength",
                        hintStyle: hintStyle ?? StyleUtility.hintTextStyle,
                        counterText: counterTextVisible
                            ? counterText ??
                                  "${maxLength - (controller?.text.length ?? 0)} characters remaining."
                            : '',
                        counterStyle:
                            counterStyle ??
                            TextStyle(
                              fontFamily: 'Roboto',
                              color: (borderColor ?? AppColors.appBorderColor)
                                  .withValues(alpha: 0.4),
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
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide(
                            color: borderColor ?? AppColors.appBorderColor,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: const BorderSide(
                            color: AppColors.appErrorRed,
                            width: 1,
                          ),
                        ),
                      ),
                  onChanged: (value) {
                    if (value.length == maxLength) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Maximum length reached'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                    onChange(value);
                  },
                  autovalidateMode: autovalidateMode,
                  validator: (validator != null)
                      ? validator
                      : (isRequired
                            ? (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              }
                            : null),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

// validator: validator != null
//                       ? (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return 'This field is required text field method calling'; // Show validation error message
//                           }
//                           return null;
//                         }
//                       : isRequired
//                       ? (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return 'This field is required text field method calling'; // Show validation error message
//                           }
//                           return null;
//                         }
//                       : null,,
