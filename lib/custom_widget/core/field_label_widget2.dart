import 'package:custom_widgets/utility/font_utility.dart';
import 'package:flutter/material.dart';
// import 'package:custom_widgets_catalog/utility/font_utility.dart';

/// A widget that displays a label for a form field.
/// 
/// Shows the field label text and optionally a red asterisk (*) if the field is required.
/// 
/// Example:
/// ```dart
/// FieldLabelWidget(
///   label: 'Email',
///   isRequired: true,
/// )
/// ```
class FieldLabelWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextStyle? textStyle;
  final TextStyle? starTextStyle;
  final EdgeInsetsGeometry padding;
  
  const FieldLabelWidget({
    super.key,
    required this.label,
    required this.isRequired,
    this.textStyle,
    this.starTextStyle,
    this.padding = const EdgeInsets.only(top: 10, bottom: 7),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: padding,
          child: RichText(            
            text: TextSpan(
              text: label,
              style: textStyle ?? StyleUtility.labelTextStyle,
              
              children:
                  isRequired == true
                      ? [
                        TextSpan(
                          text: ' *',
                          style:
                              starTextStyle ??
                              const TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ]
                      : [],
            ),
          ),
        );
  }
}
