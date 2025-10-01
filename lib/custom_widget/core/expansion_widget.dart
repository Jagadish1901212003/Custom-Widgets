import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';

class ExpanstionTileWidget extends StatelessWidget {
  final String expanstionTitle;
  final TextStyle? titleStyle;
  final List<Widget> widgetList;
  final Widget? leading;
  final Widget? suffixWidget;
  final Color? iconColor;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;
  final Color? collapsedBackgroundColor;
  final Color? backgroundColor;
  final Color? collapsedTextColor;
  final bool isExpanded;
  final void Function(bool)? onExpansionChanged;
  const ExpanstionTileWidget({
    super.key,
    required this.expanstionTitle,
    this.titleStyle,
    required this.widgetList,
    this.suffixWidget,
    this.iconColor,
    this.borderColor,
    this.padding = const EdgeInsets.all(0),
    this.leading,
    this.collapsedBackgroundColor,
    this.backgroundColor,
    this.collapsedTextColor,
    this.isExpanded = true,
    this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    print('expansion rebuild.....');
    return Padding(
      padding: padding,
      child: ExpansionTile(
        maintainState: true,
        // minTileHeight: 40,
        collapsedBackgroundColor: collapsedBackgroundColor,
        backgroundColor: backgroundColor,
        collapsedTextColor: collapsedTextColor,
        leading: leading,
        initiallyExpanded: isExpanded,
        onExpansionChanged: onExpansionChanged,
        childrenPadding: const EdgeInsets.only(bottom: 8),
        tilePadding: const EdgeInsets.only(left: 10, right: 5),
        iconColor: iconColor ?? AppColors.appBlack,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor ?? AppColors.appBorderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        collapsedShape: RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor ?? AppColors.appBorderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildExpansionTitleText(heading: expanstionTitle, context: context),
            suffixWidget ?? const SizedBox(),
          ],
        ),
        controlAffinity: ListTileControlAffinity.leading,

        children: widgetList,
      ),
    );
  }

  buildExpansionTitleText({required String heading, context}) {
    return Flexible(
      child: Text(
        heading,
        // maxLines: isExpanded ? null : 1,
        // overflow: isExpanded ? null : TextOverflow.ellipsis,
        style:
            titleStyle ??
            const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14.0,
              color: AppColors.appBlack,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
