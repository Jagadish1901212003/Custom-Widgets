import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/font_utility.dart';
import 'package:custom_widgets/utility/toast_utility.dart';
import 'package:custom_widgets/custom_widget/core/field_label_widget.dart';

class TextAreaWidget extends StatefulWidget {
  final String lable;
  final bool isRequired;
  final TextEditingController? controller;
  final bool? enabled;
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
  final bool? visibleHelperIcon;
  final String? helperText;
  final String? hintText;
  final int? minLines;
  final double? height;

  final String? initialValue;

  const TextAreaWidget({
    super.key,
    required this.lable,
    this.isRequired = false,
    this.controller,
    this.enabled = true,
    this.keyboardType,
    this.borderColor,
    this.padding = const EdgeInsets.all(0),
    this.hintStyle,
    this.borderRadius = 5,
    this.maxLength = 5000,
    this.showCounterText = false,
    this.counterText,
    this.counterStyle,
    this.cursorColor,
    this.showCursor,
    this.obscureText = false,
    this.decoration,
    required this.onChange,
    this.initialValue,
    this.visibleHelperIcon = false,
    this.helperText,
    this.hintText,
    this.minLines,
    this.height,
  });

  @override
  State<TextAreaWidget> createState() => _TextAreaWidgetState();
}

class _TextAreaWidgetState extends State<TextAreaWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: widget.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: (widget.lable != "")
                      ? FieldLableWidget(
                          lable: widget.lable,
                          isRequired: widget.isRequired,
                          visibleHelperIcon: widget.visibleHelperIcon,
                          helperText: widget.helperText,
                        )
                      : SizedBox(height: 10),
                ),
              ],
            ),
            SizedBox(
              height: widget.height, // Set fixed height
              child: TextFormField(
                //enableInteractiveSelection: false,
                initialValue: widget.initialValue,
                cursorColor: widget.cursorColor,
                showCursor: widget.showCursor,
                obscureText: widget.obscureText,
                enabled: widget.enabled,
                textInputAction: TextInputAction.next,
                controller: widget.controller,
                maxLength: widget.maxLength,
                keyboardType: widget.keyboardType ?? TextInputType.text,
                maxLines: 6, // ✅ Use fixed lines instead of expands
                minLines: widget.minLines,
                expands: false,
                decoration:
                    widget.decoration ??
                    InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      alignLabelWithHint: true,
                      filled: !widget.enabled!,
                      fillColor:
                          widget.borderColor?.withValues(alpha: 0.4) ??
                          AppColors.appBorderColor.withValues(alpha: 0.4),
                      hintText:
                          widget.hintText ??
                          "Maximum character limit is ${widget.maxLength}",
                      hintStyle: widget.hintStyle ?? StyleUtility.hintTextStyle,
                      counterText: widget.showCounterText
                          ? widget.counterText ??
                                "${widget.maxLength - widget.controller!.text.length} characters remaining."
                          : "",
                      counterStyle:
                          widget.counterStyle ??
                          TextStyle(
                            fontFamily: 'Roboto',
                            color: widget.borderColor?.withValues(alpha: 0.4),
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius,
                        ),
                        borderSide: BorderSide(
                          color: widget.borderColor ?? AppColors.appBorderColor,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius,
                        ),
                        borderSide: BorderSide(
                          color: widget.borderColor ?? AppColors.appBorderColor,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.borderColor ?? AppColors.appBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                onChanged: (value) {
                  if (widget.maxLength == value.length) {
                    ToastUtility.showErrorMessageFlushBar(
                      'Maxlength reached!',
                      context,
                    );
                  }
                  widget.onChange(value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: widget.isRequired
                    ? (value) {
                        if (value == null || value.trim().isEmpty) {
                          return " ";
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
