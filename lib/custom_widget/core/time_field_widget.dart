import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/font_utility.dart';

class TimeFieldWidget extends StatelessWidget {
  final TextEditingController? timeController;
  final EdgeInsetsGeometry padding;
  final DateTime? selectedTime;
  final void Function(dynamic) onTimeSelect;
  final String hintText;
  final TextStyle? hintTextStyle;
  final Color? iconColor;
  final Color? borderColor;
  final Widget? icon;
  final bool? isRequired;

  const TimeFieldWidget({
    super.key,
    this.timeController,
    required this.onTimeSelect,
    this.selectedTime,
    this.hintText = "Select Time - HH:MM",
    this.hintTextStyle,
    this.iconColor,
    this.borderColor,
    this.padding = const EdgeInsets.all(0),
    this.icon,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        readOnly: true,
        // textInputAction: TextInputAction.next,
        controller: timeController,
        //   autovalidateMode: AutovalidateMode.disabled,
        onTap: () async {
          final TimeOfDay? result = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (result != null) {
            var selectedTime = result.to24hours();
            DateTime date = DateTime.now();
            String second = date.second.toString().padLeft(2, '0');
            //removing last :00 (seconds)
            String selectedTimeWithoutSec = selectedTime.substring(
              0,
              selectedTime.length - 3,
            );
            String selectedTimeWithSec = "$selectedTimeWithoutSec:$second";
            print("selectedTime :: $selectedTimeWithSec");
            onTimeSelect(selectedTimeWithSec);
          }
        },
        decoration: InputDecoration(
          errorText: null, // don't show error text
          errorStyle: TextStyle(height: 0, fontSize: 0),
          isDense: true, // optional: reduce vertical space
          // Hide error message
          hintText: hintText,
          hintStyle: hintTextStyle ?? StyleUtility.hintTextStyle,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 25,
            minHeight: 25,
          ),
          suffixIcon:
              icon ??
              Container(
                margin: const EdgeInsets.all(8),
                height: 18,
                width: 18,
                child: Icon(
                  Icons.watch_later_outlined,
                  color: AppColors.appBorderColor,
                ),
              ),
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: AppColors.appErrorRed, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: AppColors.appErrorRed, width: 1),
          ),
        ),
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

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hour:$min:00";
  }
}
