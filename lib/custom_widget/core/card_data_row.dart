import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';

class CardData {
  static Widget titleRow({
    String? title,
    int? maxLines,
    required Future<void> Function() onEdit,
    required Future<void> Function() onDelete,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title ?? "",
            maxLines: maxLines ?? 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 12,
              color: AppColors.appBlack,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        PopupMenuButton<int>(
          color: AppColors.appWhite,
          padding: const EdgeInsets.all(0),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<int>(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                height: 25,
                onTap: onEdit,
                value: 1,
                child: const Row(
                  children: [
                    Icon(Icons.edit, color: AppColors.appPrimaryColor),
                    SizedBox(width: 5),
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 30,
                onTap: onDelete,
                value: 2,
                child: const Row(
                  children: [
                    Icon(Icons.delete, color: AppColors.appErrorRed),
                    SizedBox(width: 5),
                    Text(
                      "Delete",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(
              Icons.more_vert_sharp,
              size: 25,
              color: AppColors.appGreyColor,
            ),
          ),
        ),
      ],
    );
  }

  static Widget dataRow({
    required double titleWidth,
    required String title,
    String? value,
    int? maxLines,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: titleWidth,
          child: Text(
            "$title: ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Roboto',
              color: AppColors.appGreyColor,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value ?? "",
            maxLines:
                maxLines ?? 1, //for decription we can pass max line 2 or more
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Roboto',
              color: AppColors.appBlack,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
