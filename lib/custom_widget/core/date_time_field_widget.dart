import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/enum.dart';
import 'package:custom_widgets/utility/font_utility.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class DateTimeFieldWidget extends StatefulWidget {
  final TextEditingController? dateController;
  final bool? isRequired;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? selectedDate;
  final DateType type;
  final void Function(dynamic) onDateSelect;
  final EdgeInsetsGeometry? padding;
  final TextStyle? hintTextStyle;
  final Color? iconColor;
  final Color? borderColor;
  final Widget? icon;
  final String? initialValue;
  const DateTimeFieldWidget({
    super.key,
    this.dateController,
    this.isRequired,
    this.firstDate,
    this.lastDate,
    this.selectedDate,
    required this.type,
    required this.onDateSelect,
    this.padding,
    this.hintTextStyle,
    this.iconColor,
    this.borderColor,
    this.icon = const SizedBox(),
    this.initialValue,
  });

  @override
  State<DateTimeFieldWidget> createState() => _DateTimeFieldWidgetState();
}

class _DateTimeFieldWidgetState extends State<DateTimeFieldWidget> {
  //DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // _selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    print("selectedDate :::++++++ ${widget.selectedDate}");
    return Padding(
      padding: widget.padding ?? EdgeInsets.all(0),
      child: TextFormField(
        initialValue: widget.initialValue,
        readOnly: true,
        textInputAction: TextInputAction.next,
        controller: widget.dateController,
        autovalidateMode: AutovalidateMode.disabled,
        onTap: () async {
          print("Select date");
          var selectedDateTime = await DateTimePicker.showDateTimeWidget(
            context: context,
            type:
                widget.type == DateType.date
                    ? OmniDateTimePickerType.date
                    : OmniDateTimePickerType.dateAndTime,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            selectedDate: widget.selectedDate,
          );
          if (selectedDateTime != null && selectedDateTime != "") {
            print("selectedDateTime :: $selectedDateTime");
            widget.onDateSelect(selectedDateTime);
          }
        },
        decoration: InputDecoration(
          errorText: null, // don't show error text
          errorStyle: TextStyle(height: 0, fontSize: 0),
          isDense: true, // optional: reduce vertical space
          hintText:
              widget.type == DateType.date ? "Select date" : "Select date time",
          hintStyle: widget.hintTextStyle ?? StyleUtility.hintTextStyle,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 25,
            minHeight: 25,
          ),
          suffixIcon: getSuffixIconWidget(),
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.appBorderColor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.appBorderColor,
              width: 1,
            ),
          ),
          //focusedErrorBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.appBorderColor,
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
            widget.isRequired!
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

  Widget getSuffixIconWidget() {
    Widget iconWidget = const SizedBox();
    if (widget.icon is SizedBox) {
      if (widget.type == DateType.date) {
        iconWidget = Container(
          margin: const EdgeInsets.all(8),
          height: 18,
          width: 18,
          child: Icon(
            Icons.calendar_month_outlined,
            color: AppColors.appBorderColor,
          ),
        );
      } else {
        iconWidget = Container(
          margin: const EdgeInsets.all(8),
          height: 18,
          width: 18,
          child: Image.asset(
            'assets/images/date_time.png',
            color: AppColors.appBorderColor,
          ),
        );
      }
    } else {
      print("in if icon is not sizedbox");
      iconWidget = widget.icon ?? const SizedBox();
    }
    return iconWidget;
  }
}

class DateTimePicker {
  static showDateTimeWidget({
    required BuildContext context,
    required OmniDateTimePickerType type,
    DateTime? selectedDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime minDate =
        firstDate ?? DateTime(1600).subtract(const Duration(days: 3652));
    final DateTime maxDate = lastDate ?? DateTime.now();

    // Clamp selectedDate to be within firstDate and lastDate
    DateTime safeInitialDate = selectedDate ?? DateTime.now();

    if (safeInitialDate.isBefore(minDate)) {
      safeInitialDate = minDate;
    } else if (safeInitialDate.isAfter(maxDate)) {
      safeInitialDate = maxDate;
    }

    DateTime? dateTime = await showOmniDateTimePicker(
      type: type,
      theme: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light(
          primary: AppColors.appPrimaryColor,
        ),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
      context: context,
      initialDate: safeInitialDate, //selectedDate ?? DateTime.now(),
      firstDate: minDate,
      lastDate: maxDate,
      is24HourMode: true,
      isShowSeconds: true,
      minutesInterval: 1,
      secondsInterval: 1,
      isForce2Digits: true,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(maxWidth: 350, maxHeight: 650),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(Tween(begin: 0, end: 1)),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );
    print("dateTime: $dateTime");
    return dateTime;
  }
}
