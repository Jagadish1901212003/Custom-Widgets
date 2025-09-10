import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/utility_function.dart';

class TabItemWidget extends StatelessWidget {
  final int tabId;
  final String title;
  const TabItemWidget({super.key, required this.tabId, required this.title});

  @override
  Widget build(BuildContext context) {
    return Tab(
      key: key,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 25,
            height: 25,
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: AppColors.appWhite,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.appPrimaryColor),
            ),
            child: Icon(
              UtilityFunction.getIcon(tabId),
              color: AppColors.appPrimaryColor,
              size: 16,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
