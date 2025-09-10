import 'package:flutter/material.dart';
import 'package:custom_widgets/model/dropdown_item_model.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/enum.dart';

class RadioButtonWidget extends StatelessWidget {
  final List<DropdownItemModel> radioItems;
  final DropdownItemModel? radioSelectedValue;
  final RadioType direction;
  final Color? activeColor;
  final TextStyle? textStyle;
  final void Function(dynamic) onChange;
  final bool? isRequired;
  final bool? showError;

  const RadioButtonWidget({
    super.key,
    required this.radioItems,
    this.radioSelectedValue,
    this.direction = RadioType.vertical,
    this.activeColor,
    this.textStyle,
    required this.onChange,
    this.isRequired = false,
    this.showError = false,
  });

  @override
  Widget build(BuildContext context) {
    print("Radio listtile rebuild ::::${radioSelectedValue?.name}");

    return direction == RadioType.vertical
        ? ListView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: radioItems.length,
          itemBuilder: (BuildContext context, int i) {
            return RadioListTile(
              contentPadding: const EdgeInsets.all(0),
              dense: true,
              //visualDensity: const VisualDensity(horizontal: -4.0),
              activeColor: activeColor,
              fillColor:
                  isRequired! && showError!
                      ? showFocusColor(radioSelectedValue)
                      : null,
              title: Transform(
                // you can forcefully translate values left side using Transform
                transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
                child: Text(
                  radioItems[i].name,
                  style:
                      textStyle ??
                      const TextStyle(
                        fontFamily: 'Roboto',
                        color: AppColors.appBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                ),
              ),
              value: radioItems[i],
              groupValue: radioSelectedValue,
              onChanged: onChange,
            );
          },
        )
        : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: radioItems.length,
            mainAxisSpacing: 0,
            mainAxisExtent: 45,
          ),
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: radioItems.length,
          itemBuilder: (BuildContext context, int i) {
            return IgnorePointer(
              //key: Key('$radioSelectedValue'),
              ignoring: false,
              child: RadioListTile<dynamic>(
                // visualDensity: const VisualDensity(
                //     horizontal: VisualDensity.minimumDensity,
                //     vertical: VisualDensity.minimumDensity),
                // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                contentPadding: const EdgeInsets.all(0),
                dense: true,
                //visualDensity: const VisualDensity(horizontal: -4.0),
                activeColor: activeColor,
                fillColor:
                    isRequired! && showError!
                        ? showFocusColor(radioSelectedValue)
                        : null,
                title: Transform(
                  transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
                  child: Text(
                    radioItems[i].name,
                    style:
                        textStyle ??
                        const TextStyle(
                          fontFamily: 'Roboto',
                          color: AppColors.appBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                  ),
                ),
                value: radioItems[i],
                groupValue: radioSelectedValue,
                onChanged: onChange,
              ),
            );
          },
        );
  }

  showFocusColor(DropdownItemModel? selected) {
    if (selected == null) {
      return WidgetStateProperty.all(AppColors.appErrorRed);
    }
  }
}
