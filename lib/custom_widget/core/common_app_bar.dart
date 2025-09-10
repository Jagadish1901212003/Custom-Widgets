import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/font_utility.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool clearBtnVisible;
  final void Function() onClear;

  const CommonAppBar({
    super.key,
    required this.title,
    this.clearBtnVisible = true,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appSecondaryColor,
      centerTitle: false,
      elevation: 0.5,
      titleSpacing: 0.0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios, color: AppColors.appWhite),
      ),
      title: FittedBox(child: Text(title, style: StyleUtility.appBarTextStyle)),
      actions: [
        if (clearBtnVisible)
          TextButton(
            child: const Text(
              "Clear",
              style: TextStyle(
                fontFamily: 'Roboto',
                color: AppColors.appWhite,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () => onClear(),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
