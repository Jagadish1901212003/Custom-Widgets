import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:custom_widgets/model/dropdown_item_model.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/app_constants.dart';
import 'package:custom_widgets/utility/global_tabs.dart';
import 'package:custom_widgets/utility/pop_up_dialog_utility.dart';
import 'package:custom_widgets/custom_widget/core/multiselect_dropdown_widget.dart';

class PersonInvolvedAsMultiDropWidget extends StatefulWidget {
  final List<DropdownItemModel>? items;
  final void Function(List<DropdownItemModel>) onChange;
  final List<DropdownItemModel> selected;
  final void Function(List<DropdownItemModel>, DropdownItemModel, bool)
  onSelect;
  final bool? isRequired;

  const PersonInvolvedAsMultiDropWidget({
    super.key,
    required this.items,
    required this.onChange,
    required this.selected,
    required this.onSelect,
    this.isRequired = false,
  });

  @override
  State<PersonInvolvedAsMultiDropWidget> createState() =>
      _PersonInvolvedAsMultiDropWidgetNewState();
}

class _PersonInvolvedAsMultiDropWidgetNewState
    extends State<PersonInvolvedAsMultiDropWidget> {
  List<DropdownItemModel> personInvolvedAs = [];
  final Set<int> disabled = {};

  @override
  Widget build(BuildContext context) {
    updateDisabled();

    return SizedBox(
      height: 45,
      child: CustomDropdown<DropdownItemModel>.multiSelect(
        closedHeaderPadding: const EdgeInsets.all(8),
        initialItems: widget.selected,
        items: widget.items,
        canCloseOutsideBounds: true,
        hintText: 'Select Person Type',
        listValidator:
            widget.isRequired!
                ? (value) {
                  if (value.isEmpty) {
                    return "";
                  }
                  return null;
                }
                : null,
        decoration: CustomDropdownDecoration(
          closedErrorBorderRadius: BorderRadius.circular(5),
          closedBorderRadius: BorderRadius.circular(5),
          closedBorder: Border.all(color: AppColors.appBorderColor),
          closedFillColor: Colors.transparent,
          hintStyle: const TextStyle(
            fontFamily: 'Roboto',
            color: AppColors.appBorderColor,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
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
        listItemBuilder: (context, item, isSelectedFromDropdown, onItemSelect) {
          final bool isItemDisabled = disabled.contains(item.value);

          // Manually override isSelected if item is disabled
          final bool isSelected =
              isItemDisabled ? false : isSelectedFromDropdown;

          return ListTile(
            contentPadding: const EdgeInsets.all(0),
            minTileHeight: 10,
            onTap: () {
              if (isItemDisabled) {
                _showAlert(item); // Show alert only
                return;
              }
              selectHandler(onItemSelect, item, !isSelected);
            },
            title: Text(
              item.name,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 13,
                color:
                    isItemDisabled
                        ? Colors.grey
                        : isSelected
                        ? AppColors.appPrimaryColor
                        : AppColors.appBlack,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            trailing: IgnorePointer(
              ignoring: isItemDisabled,
              child: Checkbox(
                value: isSelected,
                activeColor: AppColors.appPrimaryColor,
                onChanged:
                    isItemDisabled
                        ? (checked) {
                          if (isItemDisabled) {
                            _showAlert(item); // Show alert only
                            return;
                          }
                        }
                        : (checked) =>
                            selectHandler(onItemSelect, item, !isSelected),
              ),
            ),
          );
        },
        hideSelectedFieldWhenExpanded: true,
        headerListBuilder: (context, selectedItems, enabled) {
          return ConstrainedBox(
            constraints: BoxConstraints.loose(const Size(double.infinity, 32)),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              scrollDirection: Axis.horizontal,
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                final option = selectedItems[index];
                return _buildSelectedChip(
                  option,
                  index,
                  selectedItems,
                  ChipDecoration(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    backgroundColor: AppColors.appLightPrimaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: AppColors.appBorderColor),
                    wrap: false,
                    runSpacing: 2,
                    spacing: 5,
                    labelStyle: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: AppColors.appBlack,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          );
        },
        onListChanged: (newList) {
          // Filter out disabled items forcibly
          final filtered =
              newList.where((item) => !disabled.contains(item.value)).toList();
          if (filtered.length != newList.length) {
            // If disabled items were in list, reset selection
            widget.onChange(filtered);
            setState(() {});
          } else {
            widget.onChange(newList);
          }
        },
      ),
    );
  }

  void updateDisabled() {
    disabled.clear();
    final selectedIncidentTypeValues =
        GlobalState().selectedIncidentTypes.map((e) => e.value).toList();

    if (!selectedIncidentTypeValues.contains(
      IncidentType.motorVehicleAccidentId,
    )) {
      disabled.add(PersonType.driverId);
    }
    if (!selectedIncidentTypeValues.contains(IncidentType.injuryIllnessId)) {
      disabled.add(PersonType.injuredId);
      disabled.add(PersonType.firstAiderId);
    }
  }

  Widget _buildSelectedChip(
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
            onTap: () async {
              await PopUpDialogUtility.showAlertDialog(
                context: context,
                popupTitle: 'Warning',
                description: "Are you sure you want to remove ${option.name} ?",
                buttonCallback: () async {
                  selectedItems.removeAt(index);
                  if (personInvolvedAs.isNotEmpty) {
                    personInvolvedAs.removeAt(index);
                  }

                  widget.onSelect(selectedItems, option, false);
                  widget.onChange(selectedItems);
                  setState(() {});
                },
              );
            },
            child: SizedBox(
              width: 20,
              height: 20,
              child:
                  chipDecoration.deleteIcon ??
                  const Icon(Icons.close, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  selectHandler(
    void Function() onSelect,
    DropdownItemModel selectedType,
    bool isSelected,
  ) async {
    if (disabled.contains(selectedType.value)) {
      // Show alert and ignore selection, don't call onSelect
      _showAlert(selectedType);
      setState(() {}); // Refresh UI to keep checkbox consistent
      return;
    }

    if (isSelected) {
      //for driver
      if (selectedType.value == PersonType.driverId) {
        if (GlobalState().selectedIncidentTypes
            .map((type) => type.value)
            .toList()
            .contains(IncidentType.motorVehicleAccidentId)) {
          personInvolvedAs.add(selectedType);
          onSelect();
          widget.onSelect(personInvolvedAs, selectedType, isSelected);
        } else {
          _showAlert(selectedType);
        }
      }
      //for Injury / Illness
      else if (selectedType.value == PersonType.injuredId) {
        if (GlobalState().selectedIncidentTypes
            .map((type) => type.value)
            .toList()
            .contains(IncidentType.injuryIllnessId)) {
          personInvolvedAs.add(selectedType);
          onSelect();
          widget.onSelect(personInvolvedAs, selectedType, isSelected);
        } else {
          _showAlert(selectedType);
        }
      }
      //First Aider Equipment
      else if (selectedType.value == PersonType.firstAiderId) {
        if (GlobalState().selectedIncidentTypes
            .map((type) => type.value)
            .toList()
            .contains(IncidentType.injuryIllnessId)) {
          personInvolvedAs.add(selectedType);
          onSelect();
          widget.onSelect(personInvolvedAs, selectedType, isSelected);
        } else {
          _showAlert(selectedType);
        }
      } else {
        personInvolvedAs.add(selectedType);
        onSelect();
        widget.onSelect(personInvolvedAs, selectedType, isSelected);
      }
    } else {
      //remove incident type from the list
      await PopUpDialogUtility.showAlertDialog(
        context: context,
        popupTitle: 'Warning',
        description: "Are you sure you want to remove ${selectedType.name} ?",
        buttonCallback: () async {
          personInvolvedAs.removeWhere(
            (type) => type.value == selectedType.value,
          );
          onSelect();
          widget.onSelect(personInvolvedAs, selectedType, false);
        },
      );
    }
  }

  _showAlert(DropdownItemModel type) async {
    var textMessage = "";
    if (PersonType.driverId == type.value) {
      textMessage =
          "Please select incident type Motor Vehicle/Mobile Equipment";
    } else if (PersonType.injuredId == type.value) {
      textMessage = "Please select incident type Workplace Injury/Illness";
    } else if (PersonType.firstAiderId == type.value) {
      textMessage = "Please select incident type Workplace Injury/Illness";
    }

    await PopUpDialogUtility.showAlertDialogSystem(
      context: context,
      popupTitle: 'Warning',
      description: textMessage,
    );
  }
}
