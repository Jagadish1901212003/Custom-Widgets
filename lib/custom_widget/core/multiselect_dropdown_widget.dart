import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:custom_widgets/model/dropdown_item_model.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/font_utility.dart';

class MultiSelectDropDown extends StatefulWidget {
  final String hintText;
  final bool? isRequired;

  final List<DropdownItemModel>? items;
  final void Function(List<DropdownItemModel>) onChange;
  final void Function(DropdownItemModel, bool) onCheck;
  final EdgeInsetsGeometry? margin;
  final bool searchEnabled;
  final Color? borderColor;
  final TextStyle? labelTextStyle;
  final TextStyle? hintTextStyle;
  final double chipRadius;
  final List<DropdownItemModel> selected;
  const MultiSelectDropDown({
    super.key,
    required this.selected,
    required this.hintText,
    this.isRequired = false,
    required this.items,
    required this.onChange,
    required this.onCheck,
    this.margin,
    required this.searchEnabled,
    this.borderColor,
    this.labelTextStyle,
    this.hintTextStyle,
    this.chipRadius = 10,
  });

  @override
  State<MultiSelectDropDown> createState() => _MultiSelectDropDownState();
}

class _MultiSelectDropDownState extends State<MultiSelectDropDown> {
  @override
  Widget build(BuildContext context) {
    // print("Multiselect rebuilding new");

    return Container(
      margin: widget.margin ?? const EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      child:
          widget.searchEnabled
              ? CustomDropdown<DropdownItemModel>.multiSelectSearch(
                closedHeaderPadding: const EdgeInsets.all(5),
                items: widget.items,
                initialItems: widget.selected,
                canCloseOutsideBounds: true,
                hintText: widget.hintText,
                decoration: CustomDropdownDecoration(
                  closedErrorBorder: Border.all(color: AppColors.appErrorRed),
                  closedBorderRadius: BorderRadius.circular(5),
                  closedBorder: Border.all(color: AppColors.appBorderColor),
                  closedFillColor: Colors.transparent,
                  hintStyle: widget.hintTextStyle ?? StyleUtility.hintTextStyle,
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
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.name,
                        style: StyleUtility.dropDownItemTextStyle(isSelected),
                      ),
                      Checkbox(
                        value: isSelected,
                        activeColor: AppColors.appPrimaryColor,
                        onChanged: (_) {
                          print("selected:::::::::::::::::::::::::");
                          onItemSelect();
                          //setting not selected due to it gvies on select false
                          widget.onCheck(item, !isSelected);
                        },
                      ),
                    ],
                  );
                },
                hideSelectedFieldWhenExpanded: true,
                headerListBuilder: (context, selectedItems, enabled) {
                  return ConstrainedBox(
                    constraints: BoxConstraints.loose(
                      const Size(double.infinity, 32),
                    ),
                    child: ListView.separated(
                      separatorBuilder:
                          (context, index) => const SizedBox(width: 8),
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedItems.length,
                      itemBuilder: (context, index) {
                        final option = selectedItems[index];
                        return _buildChip(
                          option,
                          index,
                          selectedItems,
                          ChipDecoration(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            backgroundColor: AppColors.appLightPrimaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(widget.chipRadius),
                            ),
                            border: Border.all(color: AppColors.appBorderColor),
                            wrap: false,
                            runSpacing: 2,
                            spacing: 5,
                            labelStyle:
                                StyleUtility.dropDownSelectedItemTextStyle,
                          ),
                        );
                      },
                    ),
                  );
                },
                onListChanged: widget.onChange,
              )
              : CustomDropdown<DropdownItemModel>.multiSelect(
                listValidator:
                    widget.isRequired!
                        ? (value) {
                          if (value.isEmpty) {
                            return "";
                          }
                          return null;
                        }
                        : null,
                closedHeaderPadding: const EdgeInsets.all(8),
                items: widget.items,
                initialItems: widget.selected,
                canCloseOutsideBounds: true,
                hintText: widget.hintText,
                decoration: CustomDropdownDecoration(
                  closedBorderRadius: BorderRadius.circular(5),
                  closedErrorBorderRadius: BorderRadius.circular(5),
                  closedBorder: Border.all(color: AppColors.appBorderColor),
                  closedFillColor: Colors.transparent,
                  hintStyle: widget.hintTextStyle ?? StyleUtility.hintTextStyle,
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
                    onTap: () {
                      onItemSelect();
                      //setting not selected due to it gvies on select false
                      widget.onCheck(item, !isSelected);
                    },
                    title: Text(
                      item.name,
                      style: StyleUtility.dropDownItemTextStyle(isSelected),
                    ),
                    trailing: Checkbox(
                      value: isSelected,
                      activeColor: AppColors.appPrimaryColor,
                      onChanged: (_) {
                        onItemSelect();
                        //setting not selected due to it gvies on select false
                        widget.onCheck(item, !isSelected);
                      },
                    ),
                  );
                },
                hideSelectedFieldWhenExpanded: true,
                headerListBuilder: (context, selectedItems, enabled) {
                  return ConstrainedBox(
                    constraints: BoxConstraints.loose(
                      const Size(double.infinity, 32),
                    ),
                    child: ListView.separated(
                      separatorBuilder:
                          (context, index) => const SizedBox(width: 8),
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedItems.length,
                      itemBuilder: (context, index) {
                        final option = selectedItems[index];
                        return _buildChip(
                          option,
                          index,
                          selectedItems,
                          ChipDecoration(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            backgroundColor: AppColors.appWhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(widget.chipRadius),
                            ),
                            border: Border.all(
                              color: AppColors.appPrimaryColor,
                            ),
                            wrap: false,
                            runSpacing: 2,
                            spacing: 5,
                            labelStyle:
                                StyleUtility.dropDownSelectedItemTextStyle,
                          ),
                        );
                      },
                    ),
                  );
                },
                onListChanged: widget.onChange,
                validateOnChange: true,
              ),
    );
  }

  Widget _buildChip(
    DropdownItemModel option,
    int index,
    List<DropdownItemModel> selectedItems,
    ChipDecoration chipDecoration,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: chipDecoration.borderRadius,
        color: chipDecoration.backgroundColor,
        border: chipDecoration.border,
      ),
      padding: chipDecoration.padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(option.name, style: chipDecoration.labelStyle),
          const SizedBox(width: 4),
          InkWell(
            onTap: () {
              selectedItems.removeAt(index);
              widget.onChange(selectedItems);
              widget.onCheck(option, false);
              setState(() {});
            },
            child: SizedBox(
              width: 20,
              height: 20,
              child:
                  chipDecoration.deleteIcon ??
                  const Icon(
                    Icons.close,
                    size: 20,
                    color: AppColors.appPrimaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Configuration class for customizing the appearance of chips in the multi-select dropdown.
class ChipDecoration {
  /// Creates a new instance of [ChipDecoration].
  ///
  /// [deleteIcon] is the icon to display for deleting a chip.
  ///
  /// [backgroundColor] is the background color of the chip.
  ///
  /// [labelStyle] is the style of the chip label.
  ///
  /// [padding] is the padding around the chip.
  ///
  /// [border] is the border of the chip.
  ///
  /// [spacing] is the spacing between chips.
  ///
  /// [runSpacing] is the spacing between chip rows (when the chips wrap).
  ///
  /// [borderRadius] is the border radius of the chip.
  ///
  /// [wrap] is whether to wrap or not.
  const ChipDecoration({
    this.deleteIcon,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    this.border = const Border(),
    this.spacing = 8,
    this.runSpacing = 12,
    this.labelStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.wrap = true,
  });

  /// The icon to display for deleting a chip.
  final Icon? deleteIcon;

  /// The background color of the chip.
  final Color? backgroundColor;

  /// The style of the chip label.
  final TextStyle? labelStyle;

  /// The padding around the chip.
  final EdgeInsets padding;

  /// The border of the chip.
  final BoxBorder border;

  /// The spacing between chips.
  final double spacing;

  /// The spacing between chip rows (when the chips wrap).
  final double runSpacing;

  /// The border radius of the chip.
  final BorderRadiusGeometry borderRadius;

  /// Whether to wrap or not
  ///
  /// If true, the chips will wrap to the next line when they reach the end of the row.
  /// If false, the chips will not wrap and will be displayed in a single line, scrolling horizontally if necessary.
  final bool wrap;
}
