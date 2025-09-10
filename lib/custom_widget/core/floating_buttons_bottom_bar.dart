import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/enum.dart';
import 'package:custom_widgets/utility/utility_function.dart';
import 'package:custom_widgets/custom_widget/core/buttons_widget.dart';

class FloatingButtonsBottomBar extends StatelessWidget {
  final bool isThreeBtn;
  final Future<void> Function() onSave;
  final Future<void> Function()? onSaveDraft;
  final Function()? onCancel;
  final ButtonType? buttonType;
  final bool isSaveEnable;
  final ButtonType? cancelButtonType;
  const FloatingButtonsBottomBar({
    super.key,
    this.isThreeBtn = false,
    required this.onSave,
    this.onSaveDraft,
    this.onCancel,
    this.buttonType,
    this.cancelButtonType,
    required this.isSaveEnable,
  });

  @override
  Widget build(BuildContext context) {
    return isThreeBtn
        ? Container(
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 10,
            right: 10,
          ),
          decoration: const BoxDecoration(
            color: AppColors.appWhite,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 8.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonWidget.buttonOutline(
                buttonSize: const Size(90, 40),
                lable: "Close",
                buttonCallback: onCancel ?? () => Navigator.pop(context),
              ),
              ButtonWidget.buttonElevated(
                buttonSize: const Size(90, 40),
                buttonCallback: onSaveDraft ?? () {},
                lable: "Save Draft",
                buttonColor:
                    isSaveEnable
                        ? AppColors.appSecondaryTextColor
                        : AppColors.appLightPrimaryColor,
              ),
              ButtonWidget.buttonElevated(
                buttonSize: const Size(90, 40),
                buttonCallback: onSave,
                lable:
                    buttonType?.name.capitalize() ??
                    ButtonType.add.name.capitalize(),
                buttonColor:
                    isSaveEnable
                        ? AppColors.appPrimaryColor
                        : AppColors.appLightPrimaryColor,
              ),
            ],
          ),
        )
        : Container(
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 10,
            right: 10,
          ),
          decoration: const BoxDecoration(
            color: AppColors.appWhite,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 8.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonWidget.buttonOutline(
                buttonSize: const Size(120, 40),
                lable:
                    cancelButtonType?.name.capitalize() ??
                    ButtonType.cancel.name.capitalize(),
                buttonCallback: onCancel ?? () => Navigator.pop(context),
              ),
              const SizedBox(width: 10),
              ButtonWidget.buttonElevated(
                buttonSize: const Size(120, 40),
                buttonCallback: onSave,
                lable:
                    buttonType?.name.capitalize() ??
                    ButtonType.add.name.capitalize(),
                buttonColor:
                    isSaveEnable
                        ? AppColors.appPrimaryColor
                        : AppColors.appLightPrimaryColor,
              ),
            ],
          ),
        );
  }
}
