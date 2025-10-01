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
                fillColor: isRequired! && showError!
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
                  contentPadding: const EdgeInsets.all(0),
                  dense: true,
                  //visualDensity: const VisualDensity(horizontal: -4.0),
                  activeColor: activeColor,
                  fillColor: isRequired! && showError!
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








///////////////// mine
class RadioButtonFormField extends FormField<DropdownItemModel> {
  RadioButtonFormField({
    super.key,
    required List<DropdownItemModel> radioItems,
    super.initialValue,
    RadioType direction = RadioType.vertical,
    Color? activeColor,
    TextStyle? textStyle,
    bool isRequired = false,
    EdgeInsetsGeometry padding = const EdgeInsets.all(0),
    required void Function(DropdownItemModel?) onChanged,
  }) : super(
         validator: (value) {
           if (isRequired && value == null) {
             // return 'This field is required';
             return '';
           }
           return null;
         },
         builder: (FormFieldState<DropdownItemModel> state) {
           Color effectiveActiveColor =
               activeColor ?? Colors.blue; // default fallback

           return Padding(
             padding: padding,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 direction == RadioType.vertical
                     ? ListView.builder(
                         padding: EdgeInsets.zero,
                         shrinkWrap: true,
                         physics: const NeverScrollableScrollPhysics(),
                         itemCount: radioItems.length,
                         itemBuilder: (context, i) {
                           return RadioListTile<DropdownItemModel>(
                             contentPadding: EdgeInsets.zero,
                             dense: true,
                             // 🔑 dynamically set fillColor
                             fillColor:
                                 MaterialStateProperty.resolveWith<Color?>((
                                   states,
                                 ) {
                                   if (state.hasError && state.value == null) {
                                     return Colors.red; // 🚨 highlight error
                                   }
                                   if (states.contains(
                                     MaterialState.selected,
                                   )) {
                                     return effectiveActiveColor;
                                   }
                                   return Colors.grey;
                                 }),
                             title: Text(
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
                             value: radioItems[i],
                             groupValue: state.value,
                             onChanged: (val) {
                               state.didChange(val);
                               onChanged(val);
                             },
                           );
                         },
                       )
                     : GridView.builder(
                         gridDelegate:
                             SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: radioItems.length,
                               mainAxisSpacing: 0,
                               mainAxisExtent: 45,
                             ),
                         shrinkWrap: true,
                         physics: const NeverScrollableScrollPhysics(),
                         itemCount: radioItems.length,
                         itemBuilder: (context, i) {
                           return RadioListTile<DropdownItemModel>(
                             dense: true,
                             fillColor:
                                 MaterialStateProperty.resolveWith<Color?>((
                                   states,
                                 ) {
                                   if (state.hasError && state.value == null) {
                                     return Colors.red;
                                   }
                                   if (states.contains(
                                     MaterialState.selected,
                                   )) {
                                     return effectiveActiveColor;
                                   }
                                   return Colors.grey;
                                 }),
                             title: Text(radioItems[i].name, style: textStyle),
                             value: radioItems[i],
                             groupValue: state.value,
                             onChanged: (val) {
                               state.didChange(val);
                               onChanged(val);
                             },
                           );
                         },
                       ),
                 if (state.hasError)
                   Padding(
                     padding: const EdgeInsets.only(top: 4, left: 12),
                     child: Text(
                       state.errorText!,
                       style: const TextStyle(
                         color: AppColors.appErrorRed,
                         fontSize: 12,
                       ),
                     ),
                   ),
               ],
             ),
           );
         },
       );
}
