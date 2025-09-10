import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:custom_widgets/model/dropdown_item_model.dart';
import 'package:custom_widgets/model/incident_details_model.dart';
import 'package:custom_widgets/model/injurey_illness_model.dart';
import 'package:custom_widgets/model/motor_vehicle_accident_model.dart';
import 'package:custom_widgets/providers/person_involved_provider.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/app_constants.dart';
import 'package:custom_widgets/utility/font_utility.dart';
import 'package:custom_widgets/utility/pop_up_dialog_utility.dart';
import 'package:custom_widgets/custom_widget/core/multiselect_dropdown_widget.dart';
import 'package:provider/provider.dart';

class IncidentTypeMultidropdownWidget extends StatefulWidget {
  final List<DropdownItemModel>? items;
  final void Function(List<DropdownItemModel>, DropdownItemModel, bool)
  onSelect;

  const IncidentTypeMultidropdownWidget({
    super.key,
    required this.items,
    required this.onSelect,
  });

  @override
  State<IncidentTypeMultidropdownWidget> createState() =>
      _IncidentTypeMultidropdownWidgetState();
}

class _IncidentTypeMultidropdownWidgetState
    extends State<IncidentTypeMultidropdownWidget> {
  List<DropdownItemModel> selectedIncidentTypes = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 45,
      child: CustomDropdown<DropdownItemModel>.multiSelect(
        closedHeaderPadding: const EdgeInsets.all(8),
        items: widget.items,
        canCloseOutsideBounds: true,
        hintText: 'Select Incident Type that is most suitable',
        decoration: CustomDropdownDecoration(
          closedBorderRadius: BorderRadius.circular(5),
          closedBorder: Border.all(color: AppColors.appBorderColor),
          closedFillColor: Colors.transparent,
          hintStyle: StyleUtility.hintTextStyle,
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
        listItemPadding: const EdgeInsets.all(0),
        listItemBuilder: (context, item, isSelected, onItemSelect) {
          return ListTile(
            // tileColor: Colors.amber,
            contentPadding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 2,
              bottom: 2,
            ),
            //minLeadingWidth: 0,
            //horizontalTitleGap: 0,
            //minLeadingWidth: 0,
            minTileHeight: 10,
            //visualDensity: VisualDensity.adaptivePlatformDensity,
            onTap:
                () => selectHandler(
                  onItemSelect,
                  item,
                  !isSelected,
                ), //setting not-selected due to it gvies on select false
            title: Text(
              item.name,
              style: StyleUtility.dropDownItemTextStyle(isSelected),
            ),
            trailing: Checkbox(
              value: isSelected,
              activeColor: AppColors.appPrimaryColor,
              onChanged:
                  (checked) => selectHandler(
                    onItemSelect,
                    item,
                    !isSelected,
                  ), // setting not-selected due to it gvies on select false
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
                    labelStyle: StyleUtility.dropDownSelectedItemTextStyle,
                  ),
                );
              },
            ),
          );
        },
        onListChanged: (value) {
          // Navigator.of(context).pop();
          // selectHandler(onItemSelect, item, !isSelected);
          print('now I am calling:::::::::::::::');
          //selectedIncidentTypes = value;
        },
      ),
    );
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
                description: "Are you sure you want to cancel?",
                buttonCallback: () async {
                  selectedItems.removeAt(index);
                  selectedIncidentTypes.removeAt(index);
                  // print('I am calling 1.....${selectedItems.length}');
                  print('I am calling 2.....${selectedIncidentTypes.length}');

                  //when person involved selected in basic details and we removing incident type related to involved person then person should be removed or updated
                  _removeInvolvedPerson(option);

                  //clear global data of selected removed tab
                  clearSelectedTabData(
                    option.value,
                    selectedIncidentTypes.length,
                  );
                  widget.onSelect(selectedItems, option, false);
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
    print("Calling select handler:::::::::::::::::");
    //add incident type in the list
    if (isSelected) {
      // if (selectedIncidentTypes
      //     .map((type) => type.value)
      //     .toList()
      //     .contains(IncidentType.nearMissId)) {
      //   await PopUpDialogUtility.showAlertDialogSystem(
      //     context: context,
      //     popupTitle: 'Warning',
      //     description:
      //         "You are not allowed to select any other incident type when 'Near Miss' is chosen.",
      //   );
      // } else

      if (selectedIncidentTypes
          .map((type) => type.value)
          .toList()
          .contains(IncidentType.hazardId)) {
        await PopUpDialogUtility.showAlertDialogSystem(
          context: context,
          popupTitle: 'Warning',
          description:
              "You are not allowed to select any other incident type when 'Hazard ID' is chosen.",
        );
      } else {
        if (selectedIncidentTypes.isNotEmpty) {
          // print('object...1');
          // if (selectedType.value == IncidentType.nearMissId) {
          //   // print('object...2');
          //   await PopUpDialogUtility.showAlertDialogSystem(
          //     context: context,
          //     popupTitle: 'Warning',
          //     description:
          //         "'Near Miss' cannot be selected in combination with other incident types.",
          //   );
          // } else

          if (selectedType.value == IncidentType.hazardId) {
            // print('object...3');
            await PopUpDialogUtility.showAlertDialogSystem(
              context: context,
              popupTitle: 'Warning',
              description:
                  "'Hazard ID' cannot be selected in combination with other incident types.",
            );
          } else {
            //   isSubmitBtnHit.value = false;

            print('object...4');
            selectedIncidentTypes.add(selectedType);
            onSelect();
            widget.onSelect(selectedIncidentTypes, selectedType, isSelected);
          }
        } else {
          //isSubmitBtnHit.value = false;

          print('object...5');
          selectedIncidentTypes.add(selectedType);
          onSelect();
          widget.onSelect(selectedIncidentTypes, selectedType, isSelected);
        }
      }
    } else {
      await PopUpDialogUtility.showAlertDialog(
        context: context,
        popupTitle: 'Warning',
        description: "Are you sure you want to cancel?",
        buttonCallback: () async {
          selectedIncidentTypes.removeWhere(
            (type) => type.value == selectedType.value,
          );
          onSelect();

          //clear global data of selected removed tab
          clearSelectedTabData(
            selectedType.value,
            selectedIncidentTypes.length,
          );
          widget.onSelect(selectedIncidentTypes, selectedType, false);

          //when person involved selected in basic details and we removing incident type related to involved person then person should be removed or updated
          _removeInvolvedPerson(selectedType);
        },
      );
    }
  }

  //INCTY

  //remove person involved as from person list on remove related incident type
  _removeInvolvedPerson(DropdownItemModel incidentType) {
    print('calling.........');
    if (incidentType.value == IncidentType.injuryIllnessId) {
      removePersonInvolvedFromListAndUpdatePerson(PersonType.injuredId);
      removePersonInvolvedFromListAndUpdatePerson(PersonType.firstAiderId);
    } else if (incidentType.value == IncidentType.motorVehicleAccidentId) {
      removePersonInvolvedFromListAndUpdatePerson(PersonType.driverId);
    }
    //  else if (incidentType.value == IncidentType.heavyEquipmentId) {
    //   removePersonInvolvedFromListAndUpdatePerson(PersonType.reportingPersonId);
    // }
  }

  Future<void> removePersonInvolvedFromListAndUpdatePerson(
    int incidentTypeId,
  ) async {
    //person list
    List<Person> person =
        Provider.of<PersonInvolvedProvider>(
          context,
          listen: false,
        ).involvedPersons;

    //iterate main person list
    for (int i = 0; i < person.length; i++) {
      //get personInvolvedAs multi select list
      List<DropdownItemModel> personInvolvedAs = person[i].role;

      // if (personInvolvedAs.length == 1) {
      //   if (personInvolvedAs[0].value == incidentTypeId) {
      //     // remove whloe person
      //     Provider.of<PersonInvolvedProvider>(context, listen: false)
      //         .removePersonInvolved(i);
      //   }
      // } else {
      //check iterating list
      //checking in person involved list INCTY id is same as incidentTypeId
      for (var j = 0; j < personInvolvedAs.length; j++) {
        Person updatedPerson = person[i];

        //if yes then remove that item from the person involved list
        if (personInvolvedAs[j].value == incidentTypeId) {
          personInvolvedAs.removeAt(j);
          //*********NEW ADDED***************** */
          if (updatedPerson.isDriver == true) {
            updatedPerson.isDriver = false;
            updatedPerson.motorVehicleAccidentModel =
                MotorVehicleAccidentModel();
            updatedPerson.passengerDetails = [];
          }
          if (updatedPerson.isInjured == true) {
            updatedPerson.isInjured = false;
            updatedPerson.injuryIllness = InjuryIllness(injuredBodyPart: []);
          }

          //***********NEW ADDED*************** */

          //update person by using updated involved list
          updatedPerson.role = personInvolvedAs;
          // Provider.of<PersonInvolvedProvider>(context, listen: false)
          //     .involvedPersons[i] = updatedPerson;

          Provider.of<PersonInvolvedProvider>(
            context,
            listen: false,
          ).updatePersonInvolved(person[i].id, updatedPerson);
        }
      }
      //}
    }
  }

  clearSelectedTabData(int selectedTabId, int tabsLength) {
    //clear additional added tabs data
    // if (tabsLength == 0) {
    //   ClearTabData().clearIncidentDetailsModelTabData();
    //   //clear attachment data
    //   ClearTabData().clearAttachmentTabData();
    //   //clear person involved data
    //   Provider.of<PersonInvolvedProvider>(
    //     context,
    //     listen: false,
    //   ).removeAllPersonInvolved();
    // }
    // switch (selectedTabId) {
    //   case IncidentType.motorVehicleAccidentId:
    //     ClearTabData().clearMotorVehicleTabData();
    //     break;

    //   case IncidentType.propertyDamageId:
    //     ClearTabData().clearPropertyDamageTabData();
    //     break;
    //   case IncidentType.environmentId:
    //     ClearTabData().clearEnvironmentTabData();
    //     break;

    //   case IncidentType.aviationOccurrenceId:
    //     ClearTabData().clearAviationOccurrenceTabData();
    //     break;
    // }
  }
}
