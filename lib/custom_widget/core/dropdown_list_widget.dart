import 'package:animated_custom_dropdown/custom_dropdown.dart';

import 'package:flutter/material.dart';
import 'package:custom_widgets/model/dropdown_item_model.dart';
import 'package:custom_widgets/utility//app_colors.dart';
import 'package:custom_widgets/utility/font_utility.dart';

class DropdownListWidget extends StatelessWidget {
  final Key? keynew;
  final bool? isRequired;
  final List<DropdownItemModel>? items;
  final void Function(DropdownItemModel?)? onChange;
  final EdgeInsetsGeometry? margin;
  final bool searchEnabled;
  final Color? borderColor;
  final TextStyle? labelTextStyle;
  final TextStyle? hintTextStyle;
  final double chipRadius;
  final DropdownItemModel? selected;
  final bool enable;
  final String hintText;
  const DropdownListWidget({
    super.key,
    this.keynew,
    this.selected,
    this.isRequired = false,
    required this.items,
    required this.onChange,
    this.margin,
    this.searchEnabled = false,
    this.borderColor,
    this.labelTextStyle,
    this.hintTextStyle,
    this.chipRadius = 10,
    this.enable = true,
    this.hintText = 'Select',
  });

  @override
  Widget build(BuildContext context) {
    print("dropdown rebuild.........");
    return Container(
      key: keynew,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      child:
          !searchEnabled
              ? CustomDropdown<DropdownItemModel>(
                enabled: enable,
                initialItem: selected,
                closedHeaderPadding: const EdgeInsets.all(9),
                items: items,
                excludeSelected: false,
                canCloseOutsideBounds: true,
                hintText: hintText,
                disabledDecoration: CustomDropdownDisabledDecoration(
                  borderRadius: BorderRadius.circular(5),
                  hintStyle: StyleUtility.hintTextStyle,
                  border: Border.all(color: AppColors.appBorderColor),
                  fillColor: AppColors.appBorderColor.withValues(alpha: 0.4),
                  suffixIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.appBlack,
                  ),
                ),
                decoration: CustomDropdownDecoration(
                  // errorText: null, // don't show error text
                  errorStyle: TextStyle(height: 0, fontSize: 0),
                  // isDense: true, // optional: reduce vertical space
                  closedBorderRadius: BorderRadius.circular(5),
                  closedBorder: Border.all(color: AppColors.appBorderColor),
                  closedErrorBorder: Border.all(color: AppColors.appErrorRed),
                  closedFillColor: Colors.transparent,
                  // closedErrorBorder: Border.all(color: AppColors.appErrorRed),
                  closedErrorBorderRadius: BorderRadius.circular(5),
                  hintStyle: hintTextStyle ?? StyleUtility.hintTextStyle,
                  closedSuffixIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.appBlack,
                  ),
                  expandedSuffixIcon: const Icon(
                    Icons.arrow_drop_up_outlined,
                    color: AppColors.appBlack,
                  ),
                  listItemDecoration: const ListItemDecoration(
                    selectedColor: AppColors.appLightPrimaryColor,
                    highlightColor: AppColors.appPrimaryColor,
                  ),
                ),
                listItemPadding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 2,
                  bottom: 2,
                ),
                listItemBuilder: (context, item, isSelected, onItemSelect) {
                  return ListTile(
                    // minVerticalPadding: 0,
                    contentPadding: const EdgeInsets.all(0),
                    minTileHeight: 10,
                    selected: isSelected,
                    title: Text(
                      item.name,
                      style: StyleUtility.dropDownItemTextStyle(isSelected),
                    ),
                  );
                },
                hideSelectedFieldWhenExpanded: true,
                headerBuilder: (context, selectedItem, enabled) {
                  return Text(
                    selectedItem.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        labelTextStyle ??
                        StyleUtility.dropDownSelectedItemTextStyle,
                  );
                },
                onChanged: onChange,
                validateOnChange: true,
                validator:
                    isRequired!
                        ? (value) {
                          if (value == null) {
                            return '';
                          }
                          return null;
                        }
                        : null,
              )
              : CustomDropdown<DropdownItemModel>.search(
                enabled: enable,
                closedHeaderPadding: const EdgeInsets.all(8),
                items: items,
                initialItem: selected,
                canCloseOutsideBounds: true,
                hintText: hintText,
                decoration: CustomDropdownDecoration(
                  closedBorderRadius: BorderRadius.circular(5),
                  closedBorder: Border.all(color: AppColors.appBorderColor),
                  closedFillColor: Colors.transparent,
                  hintStyle: hintTextStyle ?? StyleUtility.hintTextStyle,
                  closedSuffixIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.appBlack,
                  ),
                  expandedSuffixIcon: const Icon(
                    Icons.arrow_drop_up_outlined,
                    color: AppColors.appBlack,
                  ),
                  listItemDecoration: const ListItemDecoration(
                    selectedColor: AppColors.appLightPrimaryColor,
                    highlightColor: AppColors.appPrimaryColor,
                  ),
                ),
                listItemPadding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 2,
                  bottom: 2,
                ),
                listItemBuilder: (context, item, isSelected, onItemSelect) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    minTileHeight: 10,
                    selected: isSelected,
                    title: Text(
                      item.name,
                      style: StyleUtility.dropDownItemTextStyle(isSelected),
                    ),
                  );
                },
                headerBuilder: (context, selectedItem, enabled) {
                  return Text(
                    selectedItem.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        labelTextStyle ??
                        StyleUtility.dropDownSelectedItemTextStyle,
                  );
                },
                hideSelectedFieldWhenExpanded: true,
                onChanged: onChange,
              ),
    );
  }
}
