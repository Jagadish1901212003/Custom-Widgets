import 'dart:convert';
import 'package:custom_widgets/custom_widget/core/common_app_bar.dart';
import 'package:custom_widgets/custom_widget/core/date_time_field_widget.dart';
import 'package:custom_widgets/custom_widget/core/dropdown_list_widget.dart';
import 'package:custom_widgets/custom_widget/core/field_label_widget.dart';
import 'package:custom_widgets/custom_widget/core/floating_buttons_bottom_bar.dart';
import 'package:custom_widgets/custom_widget/core/radio_button_widget.dart';
import 'package:custom_widgets/custom_widget/core/search_dropdown_widget.dart';
import 'package:custom_widgets/custom_widget/core/text_area_widget.dart';
import 'package:custom_widgets/custom_widget/core/text_field_widget2.dart';
import 'package:custom_widgets/model/dropdown_item_model.dart';
import 'package:custom_widgets/model/employee_model.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/enum.dart';
import 'package:custom_widgets/utility/global_tabs.dart';
import 'package:custom_widgets/utility/pop_up_dialog_utility.dart';
import 'package:custom_widgets/view/Screens/Corrective_Actions_In_Custom_TabBar_Screen.dart';
import 'package:custom_widgets/view/Screens/attachments_tab_in_custom_tab_bar_screen.dart';
import 'package:custom_widgets/view/Screens/custom_tab_bar.dart';
import 'package:custom_widgets/view/Screens/globals.dart';
import 'package:custom_widgets/view/Screens/inspection_tab_in_custom_tab_bar_screen.dart';
import 'package:custom_widgets/view/Screens/linked_unlinked_incident_page.dart';
import 'package:custom_widgets/view/Screens/notes_in_custom_tab_bar_screen.dart';
import 'package:custom_widgets/view/Screens/search_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InspectionChecklistScreen extends StatefulWidget {
  const InspectionChecklistScreen({super.key});

  @override
  State<InspectionChecklistScreen> createState() =>
      _InspectionChecklistScreenState();
}

class _InspectionChecklistScreenState extends State<InspectionChecklistScreen> {
  final inspectionChecklistTopSectionFormKey = GlobalKey<FormState>();

  final _formKey2 = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  bool isAddEnabled = false;
  DropdownItemModel? _selectedInspectionType;

  // Declare this key in InspectionChecklistScreen
  final GlobalKey<InspectionTabInCustomTabBarScreenState> _inspectionTabKey =
      GlobalKey<InspectionTabInCustomTabBarScreenState>();

  final List<DropdownItemModel> inspectionType = [
    DropdownItemModel(id: 1, name: "ENV Inspection", value: 1),
    DropdownItemModel(id: 2, name: "ESC Inspection", value: 2),
    DropdownItemModel(id: 3, name: "Environmental Site Evaluation", value: 3),
    DropdownItemModel(id: 4, name: "Fish Rescue", value: 4),
    DropdownItemModel(id: 5, name: "Property Review", value: 5),
    DropdownItemModel(id: 6, name: "Sample Collection", value: 6),
  ];

  int selectedTabIndex = 0;
  bool hasSelectedInspectionType = false;
  // DropdownItemModel? _selectedFileType;

  final TextEditingController inspectorNameController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController siteSupervisorController =
      TextEditingController();
  final TextEditingController projectDescController = TextEditingController();
  final TextEditingController approveNOController = TextEditingController();

  EmployeeModel? loginUser;
  EmployeeModel? reportedByDetails1;
  EmployeeModel? reportedByDetails2;
  EmployeeModel? reportedByDetails3;
  DropdownItemModel? selectedValue;

  final List<DropdownItemModel> linkedToAnIncidentYesNo = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
  ];

  final List<CustomTabBarItem> tabItems = [
    CustomTabBarItem(icon: Icons.search, label: 'Inspection'),
    CustomTabBarItem(icon: Icons.build, label: 'Corrective Actions'),
    CustomTabBarItem(icon: Icons.notes, label: 'Notes'),
    CustomTabBarItem(icon: Icons.attachment, label: 'Attachments'),
  ];

  // Now matches 4 tabs
  List<Widget> get sectionWidgets => [
    //Inspection tab icon
    InspectionTabInCustomTabBarScreen(
      formKey: _formKey,
      formKey2: _formKey2,
      key: _inspectionTabKey,
      selectedInspectionType: _selectedInspectionType,
    ),

    // corrective actions tab icon
    CorrectiveActionsInCustomTabBarScreen(),

    // notes tab icon
    NotesInCustomTabBarScreen(),

    // attachments tab icon
    AttachmentsTabInCustomTabBarScreen(),
  ];

  Map<String, dynamic> generatePayload() {
    return {
      "inspectionChecklist": {
        "incidentTypes": _selectedInspectionType?.name,

        // GlobalState().selectedInspectionType
        //     .map((e) => e.name)
        //     .toList(),
        "inspectorName": inspectorNameController.text,
        "company": companyController.text,
        "siteSupervisor": siteSupervisorController.text,
        "project": projectDescController.text,
        "approvalNumber": approveNOController.text,
        "linkedToIncident": selectedValue!.name,
      },
      "inspectionTab": (_selectedInspectionType?.id == 1)
          ? {
              "siteName":
                  _inspectionTabKey.currentState?.siteNameController.text,
              "inspectionDate":
                  _inspectionTabKey.currentState?.dateOfEventController.text,
              "inspectionTime":
                  _inspectionTabKey.currentState?.timeOfEventController.text,
              "siteType":
                  _inspectionTabKey.currentState?.selectedSiteType?.name,
              "construction status": _inspectionTabKey
                  .currentState
                  ?.selectedConstructionStatus
                  ?.name,

              "Weather Status":
                  _inspectionTabKey.currentState?.selectedWeatherStatus?.name,
              "wind": _inspectionTabKey.currentState?.selectedWind?.name,
              "ground condition":
                  _inspectionTabKey.currentState?.selectedGroundCondition?.name,
              "temperature":
                  _inspectionTabKey.currentState?.temperatureController.text,

              "location":
                  _inspectionTabKey.currentState?.locationController.text,
              "Administartive Controls": {
                "Q1": _inspectionTabKey
                    .currentState
                    ?.selectedValueAdministratorControls1
                    ?.name,
                "Q2": _inspectionTabKey
                    .currentState
                    ?.selectedValueAdministratorControls2
                    ?.name,
                "Q3": _inspectionTabKey
                    .currentState
                    ?.selectedValueAdministratorControls3
                    ?.name,
                "Q4": _inspectionTabKey
                    .currentState
                    ?.selectedValueAdministratorControls4
                    ?.name,
              },
              "Erosion and Sediment Control": {
                "Q1": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControl1
                    ?.name,
                "Q2": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControl2
                    ?.name,
                "Q3": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControl3
                    ?.name,
                "Q4": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControl4
                    ?.name,
                "Q5": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControl5
                    ?.name,
                "Q6": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControl6
                    ?.name,
                "Q7": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControl7
                    ?.name,
                "Q8": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControl8
                    ?.name,
              },

              "Fuel and Oil Management": {
                "Q1": _inspectionTabKey
                    .currentState
                    ?.selectedValueFuelAndOilManagement1
                    ?.name,
                "Q2": _inspectionTabKey
                    .currentState
                    ?.selectedValueFuelAndOilManagement2
                    ?.name,
                "Q3": _inspectionTabKey
                    .currentState
                    ?.selectedValueFuelAndOilManagement3
                    ?.name,
                "Q4": _inspectionTabKey
                    .currentState
                    ?.selectedValueFuelAndOilManagement4
                    ?.name,
              },

              "Waste Management": {
                "Q1": _inspectionTabKey
                    .currentState
                    ?.selectedValueWasteManagement1
                    ?.name,
                "Q2": _inspectionTabKey
                    .currentState
                    ?.selectedValueWasteManagement2
                    ?.name,
                "Q3": _inspectionTabKey
                    .currentState
                    ?.selectedValueWasteManagement3
                    ?.name,
              },

              "Wildlife": {
                "Q1": _inspectionTabKey
                    .currentState
                    ?.selectedValueWildlife1
                    ?.name,
                "Q2": _inspectionTabKey
                    .currentState
                    ?.selectedValueWildlife2
                    ?.name,
                "Q3": _inspectionTabKey
                    .currentState
                    ?.selectedValueWildlife3
                    ?.name,
              },

              "Air Quality Management": {
                "Q1": _inspectionTabKey
                    .currentState
                    ?.selectedValueairQualityManagement1
                    ?.name,
                "Q2": _inspectionTabKey
                    .currentState
                    ?.selectedValueairQualityManagement2
                    ?.name,
                "Q3": _inspectionTabKey
                    .currentState
                    ?.selectedValueairQualityManagement3
                    ?.name,
              },
              "Archaeology": {
                "Q1": _inspectionTabKey
                    .currentState
                    ?.selectedValueArchaeology1
                    ?.name,
              },
            }
          : (_selectedInspectionType?.id == 2)
          ? {
              "Erosion and Sediment Control": {
                "Q1": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControlInESCInspection1
                    ?.name,
                "Q2": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControlInESCInspection2
                    ?.name,
                "Q3": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControlInESCInspection3
                    ?.name,
                "Q4": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControlInESCInspection4
                    ?.name,
                "Q5": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControlInESCInspection5
                    ?.name,
                "Q6": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControlInESCInspection6
                    ?.name,
                "Q7": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControlInESCInspection7
                    ?.name,
                "Q8": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControlInESCInspection8
                    ?.name,
                "Q9": _inspectionTabKey
                    .currentState
                    ?.selectedValueErosionAndSedimentControlInESCInspection9
                    ?.name,
              },
              "Water Management": {
                "Q1": _inspectionTabKey
                    .currentState
                    ?.selectedValueWaterManagementInESCInspection1
                    ?.name,
                "Q2": _inspectionTabKey
                    .currentState
                    ?.selectedValueWaterManagementInESCInspection2
                    ?.name,
                "Q3": _inspectionTabKey
                    .currentState
                    ?.selectedValueWaterManagementInESCInspection3
                    ?.name,
                "Q4": _inspectionTabKey
                    .currentState
                    ?.selectedValueWaterManagementInESCInspection4
                    ?.name,
                "Q5": _inspectionTabKey
                    .currentState
                    ?.selectedValueWaterManagementInESCInspection5
                    ?.name,
                "Q6": _inspectionTabKey
                    .currentState
                    ?.selectedValueWaterManagementInESCInspection6
                    ?.name,
                "Q7": _inspectionTabKey
                    .currentState
                    ?.selectedValueWaterManagementInESCInspection7
                    ?.name,
                "Q8": _inspectionTabKey
                    .currentState
                    ?.selectedValueWaterManagementInESCInspection8
                    ?.name,
              },

              "Site Conditions & Housekeeping": {
                "Q1": _inspectionTabKey
                    .currentState
                    ?.selectedValueSiteConditionsHousekeeping1
                    ?.name,
                "Q2": _inspectionTabKey
                    .currentState
                    ?.selectedValueSiteConditionsHousekeeping2
                    ?.name,
                "Q3": _inspectionTabKey
                    .currentState
                    ?.selectedValueSiteConditionsHousekeeping3
                    ?.name,
              },
            }
          : (_selectedInspectionType?.id == 3)
          ? {
              "Description": {
                "Q1": _inspectionTabKey
                    .currentState
                    ?.selectedValueEnvironmentalSite1
                    ?.name,
                "Q2": _inspectionTabKey
                    .currentState
                    ?.selectedValueEnvironmentalSite2
                    ?.name,
                "Q3": _inspectionTabKey
                    .currentState
                    ?.selectedValueEnvironmentalSite3
                    ?.name,
                "Q4": _inspectionTabKey
                    .currentState
                    ?.selectedValueEnvironmentalSite4
                    ?.name,
                "Q5": _inspectionTabKey
                    .currentState
                    ?.selectedValueEnvironmentalSite5
                    ?.name,
                "Q6": _inspectionTabKey
                    .currentState
                    ?.selectedValueEnvironmentalSite6
                    ?.name,
                "Q7": _inspectionTabKey
                    .currentState
                    ?.selectedValueEnvironmentalSite7
                    ?.name,
                "Q8": _inspectionTabKey
                    .currentState
                    ?.selectedValueEnvironmentalSite8
                    ?.name,
                "Q9": _inspectionTabKey
                    .currentState
                    ?.selectedValueEnvironmentalSite9
                    ?.name,
                "Q10": _inspectionTabKey
                    .currentState
                    ?.selectedValueEnvironmentalSite10
                    ?.name,
                "Q11": _inspectionTabKey
                    .currentState
                    ?.selectedValueEnvironmentalSite11
                    ?.name,
                "Q12": _inspectionTabKey
                    .currentState
                    ?.selectedValueEnvironmentalSite12
                    ?.name,
                "Q13": _inspectionTabKey
                    .currentState
                    ?.selectedValueEnvironmentalSite13
                    ?.name,
              },
            }
          : (_selectedInspectionType?.id == 5)
          ? {
              "Property Review Type": _inspectionTabKey
                  .currentState
                  ?.selectedPropertyReviewTypeType
                  ?.name,
              "Review Completed By": _inspectionTabKey
                  .currentState
                  ?.reviewCompletedByController
                  .text,
              "Location":
                  _inspectionTabKey.currentState?.locationController.text,
              "# of PIDs": {"pidList": _inspectionTabKey.currentState?.pidList},
              "totalPropertySizeController": _inspectionTabKey
                  .currentState
                  ?.totalPropertySizeController
                  .text,
              "Property Zoning":
                  _inspectionTabKey.currentState?.selectedPropertyZoning?.name,
              "Property Use":
                  _inspectionTabKey.currentState?.selectedPropertyZoning?.name,
              "Items Onsite":
                  _inspectionTabKey.currentState?.selectedItemsOnsite,
            }
          : (),
      // "attachments": {
      //   "documents": documentFiles.map((f) => path.basename(f.path)).toList(),
      //   "photos": photoFiles.map((f) => path.basename(f.path)).toList(),
      // },
      // "correctiveActions": submittedCorrectiveActions,
      "correctiveActions": submittedCorrectiveActions.map((action) {
        return {
          "uniqueId": action["uniqueId"],
          "assignTo": action["assignTo"],
          "priority": (action["priority"] as DropdownItemModel).name,
          "caCategory": (action["caCategory"] as DropdownItemModel).name,
          "status": (action["status"] as DropdownItemModel).name,
          "dueDate": action["dueDate"],
          "caDescription": action["caDescription"],
          "notes": action["notes"],
        };
      }).toList(),
      "notes": NotesInCustomTabBarScreen.notes
          .map(
            (note) => {"date": note.date.toIso8601String(), "note": note.note},
          )
          .toList(),
    };
  }

  bool validateForm() {
    errors.clear();

    // 1. Incident Types
    // if (GlobalState().selectedInspectionType.isEmpty) {

    if (_selectedInspectionType?.name == null) {
      errors.add("Please select at least one Inspection Type.");
    }

    // 2. Inspector Name
    if (inspectorNameController.text.trim().isEmpty) {
      errors.add("Inspector Name is required.");
    }

    // 3. Company
    if (companyController.text.trim().isEmpty) {
      errors.add("Company is required.");
    }

    // 4. Site Supervisor
    if (siteSupervisorController.text.trim().isEmpty) {
      errors.add("Site Supervisor is required.");
    }

    // 5. Approval No
    if (approveNOController.text.trim().isEmpty) {
      errors.add("Approval No is required.");
    }

    // 6. Radio button selection
    if (selectedValue == null) {
      errors.add("Please select whether this is linked to an Incident.");
    }

    // validate InspectionTabInCustomTabBarScreen
    _inspectionTabKey.currentState!.validateInspectionTab();

    if (errors.isNotEmpty) {
      // Show all validation errors in a dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Validation Error"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: errors.map((e) => Text("• $e")).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    inspectorNameController.dispose();
    companyController.dispose();
    siteSupervisorController.dispose();
    projectDescController.dispose();
    approveNOController.dispose();
    super.dispose();
  }

  void setReportedByDetails1(EmployeeModel user) {
    reportedByDetails1 = user;
    inspectorNameController.text = user.empName;
    setState(() {});
  }

  void setReportedByDetails2(EmployeeModel user) {
    reportedByDetails2 = user;
    companyController.text = user.empName;
    setState(() {});
  }

  void setReportedByDetails3(EmployeeModel user) {
    reportedByDetails3 = user;
    siteSupervisorController.text = user.empName;
    setState(() {});
  }

  SliverPersistentHeader makeStickyTabBar() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _StickyTabBarDelegate(
        child: Container(
          color: Colors.white,
          // padding: EdgeInsets.symmetric(vertical: 10),
          child: CustomTabBar(
            selectedInspectionType: _selectedInspectionType,
            items: tabItems,
            selectedIndex: selectedTabIndex,
            onTap: (index) async {
              // If user taps on the current tab, just return (no navigation)
              if (index == selectedTabIndex) return;

              // Validate only if currently on Inspection tab (index 0)
              if (selectedTabIndex == 0) {
                bool allowToNavigateOrNot1 =
                    inspectionChecklistTopSectionFormKey.currentState!
                        .validate();
                bool allowToNavigateOrNot2 = _formKey.currentState!.validate();

                if (!allowToNavigateOrNot1 || !allowToNavigateOrNot2) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      // icon: const Icon(Icons.warning, color: Colors.orange),
                      // title: const Text("Warning"),
                      title: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.warning, color: Colors.orange),
                              SizedBox(width: 5),
                              const Text("Warning"),
                              SizedBox(width: 5),
                            ],
                          ),
                          Divider(color: Colors.orange),
                        ],
                      ),
                      content: const Text("Please fill all mandatory details."),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            backgroundColor: AppColors.appPrimaryColor,
                            // minimumSize: buttonSize ?? const Size(100, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                          child: const Text(
                            "OK",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                  return;
                }
              }

              // If validation passed or current tab is not Inspection, allow tab switch
              if (mounted) {
                setState(() {
                  selectedTabIndex = index;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  void isAddEnable() {
    isAddEnabled = false;
    if (_selectedInspectionType != null) {
      isAddEnabled = true;
    }
    setState(() {});
  }

  final TextEditingController dateOfEventController = TextEditingController();
  final GlobalState _globalState = GlobalState();

  DateTime now = DateTime.now();

  // Radio items for "Is this linked to an Inspection?"
  final List<DropdownItemModel> linkedToAnInspectionYesNo = [
    DropdownItemModel(name: "Yes", value: 1, id: 1),
    DropdownItemModel(name: "No", value: 2, id: 2),
  ];

  // Selected value for "Is this linked to an Inspection?"
  DropdownItemModel? selectedValueInspection;

  @override
  void initState() {
    super.initState();
    _globalState.incidentDetails.basicDetailsModel?.dateOfIncReported =
        DateFormat('yyyy-MM-dd').format(now);
    // _globalState.incidentDetails.basicDetailsModel?.timeOfIncReported =
    //     DateFormat('HH:mm:ss').format(now);
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build called ======");
    final List<Widget> topWidgets = [
      const FieldLableWidget(
        // padding: EdgeInsets.only(left: 15),
        lable: "Inspection Type",
        isRequired: true,
      ),
      DropdownListWidget(
        hintText: "Inspection Type",
        margin: EdgeInsets.symmetric(horizontal: 0),
        selected: _selectedInspectionType,

        isRequired: true,
        items: inspectionType,
        onChange: (value) async {
          print("Selected name: ${value!.name}");
          _selectedInspectionType = value;
          isAddEnable();
        },
      ),
      if (_selectedInspectionType?.name == "Property Review")
        const SizedBox(height: 10),
      if (_selectedInspectionType?.name == "Property Review")
        const FieldLableWidget(
          lable: "Date of Inspection",
          isRequired: true,
          padding: EdgeInsets.symmetric(horizontal: 15),
        ),
      if (_selectedInspectionType?.name == "Property Review")
        DateTimeFieldWidget(
          padding: EdgeInsets.symmetric(horizontal: 15),

          key: Key(DateTime.now().toString()),
          isRequired: true,
          selectedDate:
              _globalState.incidentDetails.basicDetailsModel?.incidentDate,
          dateController: dateOfEventController,
          type: DateType.date,
          onDateSelect: (date) {
            // timeOfEventController.clear();

            dateOfEventController.text = DateFormat(
              'MMM dd, yyyy',
            ).format(date);
            setState(() {});
          },
        ),

      // const SizedBox(height: 10),
      const FieldLableWidget(
        lable: "Inspector Name",
        isRequired: true,
        // padding: EdgeInsets.only(left: 15),
      ),
      SearchDropdownWidget(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        controller: inspectorNameController,
        icon: Icon(Icons.person),
        isRequired: true,
        hintText: 'Your Name',
        hintTextStyle: TextStyle(fontSize: 12, color: Colors.grey),
        onTap: () {
          Navigator.push<EmployeeModel>(
            context,
            MaterialPageRoute(
              builder: (_) => const SearchEmployeeScreen(title: 'Employee'),
            ),
          ).then((selectedEmployee) {
            if (selectedEmployee != null) {
              if (loginUser?.empId == selectedEmployee.empId) {
                PopUpDialogUtility.showAlertDialogSystem(
                  context: context,
                  popupTitle: 'Warning',
                  description:
                      "Reporting Person cannot be the same as the Incident Entered By.",
                );
                return;
              }
              setReportedByDetails1(selectedEmployee);
            }
          });
        },
      ),
      // const SizedBox(height: 10),
      const FieldLableWidget(
        lable: "Company",
        isRequired: true,
        // padding: EdgeInsets.only(left: 15),
      ),
      SearchDropdownWidget(
        hintTextStyle: TextStyle(fontSize: 12, color: Colors.grey),

        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        controller: companyController,
        icon: Icon(Icons.contact_page),
        isRequired: true,
        hintText: 'Company',
        onTap: () {
          Navigator.push<EmployeeModel>(
            context,
            MaterialPageRoute(
              builder: (_) => const SearchEmployeeScreen(title: 'Company'),
            ),
          ).then((selectedEmployee) {
            if (selectedEmployee != null) {
              if (loginUser?.empId == selectedEmployee.empId) {
                PopUpDialogUtility.showAlertDialogSystem(
                  context: context,
                  popupTitle: 'Warning',
                  description:
                      "Reporting Person cannot be the same as the Incident Entered By.",
                );
                return;
              }
              setReportedByDetails2(selectedEmployee);
            }
          });
        },
      ),
      // const SizedBox(height: 10),
      const FieldLableWidget(
        lable: "Site Supervisor",
        isRequired: true,
        // padding: EdgeInsets.only(left: 15),
      ),
      SearchDropdownWidget(
        hintTextStyle: TextStyle(fontSize: 12, color: Colors.grey),

        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        controller: siteSupervisorController,
        icon: Icon(Icons.person),
        isRequired: true,
        hintText: 'Site person',
        onTap: () {
          Navigator.push<EmployeeModel>(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const SearchEmployeeScreen(title: 'Site Supervisor'),
            ),
          ).then((selectedEmployee) {
            if (selectedEmployee != null) {
              if (loginUser?.empId == selectedEmployee.empId) {
                PopUpDialogUtility.showAlertDialogSystem(
                  context: context,
                  popupTitle: 'Warning',
                  description:
                      "Reporting Person cannot be the same as the Incident Entered By.",
                );
                return;
              }
              setReportedByDetails3(selectedEmployee);
            }
          });
        },
      ),
      // const SizedBox(height: 10),
      TextAreaWidget(
        height: 70,
        enabled: (companyController.text.isEmpty) ? false : true,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        hintText: "Description",
        controller: projectDescController,
        lable: "Project #",
        onChange: (value) {},
      ),
      // const SizedBox(height: 10),
      TextAreaWidget(
        minLines: 1,
        height: 70,
        isRequired: true,
        keyboardType: TextInputType.number,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        hintText: "N/A if not applicable to inspect",
        controller: approveNOController,
        lable: "Approval No #",
        onChange: (value) {},
      ),

      // const SizedBox(height: 10),
      AbsorbPointer(
        absorbing: true,
        child: Opacity(
          opacity: 0.5,
          child: const FieldLableWidget(
            lable: "Is this linked to an Incident?",
            isRequired: true,
            padding: EdgeInsets.all(0),
          ),
        ),
      ),

      AbsorbPointer(
        absorbing: true,
        child: Opacity(
          opacity: 0.5,
          child: RadioButtonFormField(
            padding: (_selectedInspectionType?.name == "Fish Rescue")
                ? EdgeInsets.only(bottom: 50)
                : EdgeInsets.all(0),
            radioItems: linkedToAnIncidentYesNo,
            // initialValue: selectedValue,
            initialValue: linkedToAnIncidentYesNo[1],

            direction: RadioType.vertical,
            activeColor: AppColors.appPrimaryColor,
            isRequired: false,
            onChanged: (newValue) {
              setState(() {
                selectedValue = newValue;
              });
              if (selectedValue?.name == "Yes") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LinkedUnlinkedIncidentPage(
                      btnName1: "Link Incident",
                      btnName2: "Unlink Incident",
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),

      if (_selectedInspectionType?.name == "Sample Collection")
        const SizedBox(height: 10),
      if (_selectedInspectionType?.name == "Sample Collection")
        AbsorbPointer(
          absorbing: true,
          child: Opacity(
            opacity: 0.5,
            child: const FieldLableWidget(
              lable: "Is this linked to an Inspection?",
              isRequired: true,
              padding: EdgeInsets.all(0),
            ),
          ),
        ),
      if (_selectedInspectionType?.name == "Sample Collection")
        // RadioButtonWidget(
        //   radioItems: linkedToAnInspectionYesNo,
        //   radioSelectedValue: selectedValueInspection,
        //   direction: RadioType.vertical,
        //   activeColor: AppColors.appPrimaryColor,
        //   isRequired: true,
        //   showError: false,
        //   onChange: (newValue) {
        //     WidgetsBinding.instance.addPostFrameCallback((_) {
        //       if (mounted) {
        //         setState(() {
        //           selectedValueInspection = newValue as DropdownItemModel;
        //         });
        //       }
        //     });
        //   },
        //   textStyle: const TextStyle(fontSize: 16),
        // ),
        AbsorbPointer(
          absorbing: true,
          child: Opacity(
            opacity: 0.5,
            child: RadioButtonFormField(
              radioItems: linkedToAnInspectionYesNo,
              // initialValue: selectedValueInspection,
              initialValue: linkedToAnInspectionYesNo[1],

              direction: RadioType.vertical,
              activeColor: AppColors.appPrimaryColor,
              isRequired: false,
              onChanged: (newValue) {
                setState(() {
                  selectedValueInspection = newValue;
                });
                if (selectedValueInspection?.name == "Yes") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LinkedUnlinkedIncidentPage(
                        btnName1: "Link Inspection",
                        btnName2: "Unlink Inspection",
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
    ];

    return Scaffold(
      appBar: CommonAppBar(
        title: "Inspection Checklist",
        clearBtnVisible: false,
        centerTitle: true,
        onClear: () {},
      ),
      body: Form(
        key: inspectionChecklistTopSectionFormKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: CustomScrollView(
          slivers: [
            // 1st section
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 3,
                    left: 15,
                    right: 15,
                  ),
                  child: Container(
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      color: Colors.white,

                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // elevation: 4,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 10,
                        right: 16,
                        left: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: topWidgets,
                      ),
                    ),
                  ),
                ),
                if (!hasSelectedInspectionType)
                  const SizedBox(
                    height: 20,
                  ), // spacing before tabbar if not shown
              ]),
            ),

            // 2nd section
            // if (hasSelectedInspectionType) makeStickyTabBar(),
            if (_selectedInspectionType != null &&
                _selectedInspectionType?.name != "Fish Rescue")
              makeStickyTabBar(),

            // 3rd section
            if (_selectedInspectionType != null &&
                _selectedInspectionType?.name != "Fish Rescue")
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    padding: const EdgeInsets.only(top: 20, bottom: 80),
                    child: IndexedStack(
                      index: selectedTabIndex,
                      children: sectionWidgets,
                    ),
                  ),
                ]),
              ),
            // if (_selectedInspectionType != null &&
            //     _selectedInspectionType?.name != "Fish Rescue")
            //   SliverToBoxAdapter(
            //     child:
            //         sectionWidgets[selectedTabIndex], // only show the active tab
            //   ),
          ],
        ),
      ),

      // resizeToAvoidBottomInset: false, // This is true by default
      bottomNavigationBar: _selectedInspectionType != null
          ? FloatingButtonsBottomBar(
              cancelButtonType: ButtonType.close,
              buttonType: selectedTabIndex == 3
                  ? ButtonType.submit
                  : ButtonType.next,
              onSave: () async {
                print("object");
                print(selectedTabIndex);
                if (selectedTabIndex == 3) {
                  // logic on submit
                  final payload = generatePayload();
                  print("=========================");
                  print(payload);
                  // print(jsonEncode(payload));
                  print("=========================");
                  return;
                }

                try {
                  // if (selectedTabIndex == 0) {
                  //   bool allowToNavigateOrNot1 =
                  //       inspectionChecklistTopSectionFormKey.currentState!
                  //           .validate();
                  //   bool allowToNavigateOrNot2 = _formKey.currentState!
                  //       .validate();

                  //   if (!allowToNavigateOrNot1 || !allowToNavigateOrNot2) {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) => AlertDialog(
                  //         backgroundColor: Colors.white,
                  //         // icon: const Icon(Icons.warning, color: Colors.orange),
                  //         // title: const Text("Warning"),
                  //         title: Column(
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.start,
                  //               children: [
                  //                 const Icon(
                  //                   Icons.warning,
                  //                   color: Colors.orange,
                  //                 ),
                  //                 SizedBox(width: 5),
                  //                 const Text("Warning"),
                  //                 SizedBox(width: 5),
                  //               ],
                  //             ),
                  //             Divider(color: Colors.orange),
                  //           ],
                  //         ),
                  //         content: const Text(
                  //           "Please fill all mandatory details.",
                  //         ),
                  //         actions: [
                  //           ElevatedButton(
                  //             onPressed: () => Navigator.pop(context),
                  //             style: ElevatedButton.styleFrom(
                  //               padding: const EdgeInsets.symmetric(
                  //                 horizontal: 15,
                  //               ),
                  //               backgroundColor: AppColors.appPrimaryColor,
                  //               // minimumSize: buttonSize ?? const Size(100, 40),
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.all(
                  //                   Radius.circular(15),
                  //                 ),
                  //               ),
                  //             ),
                  //             child: const Text(
                  //               "OK",
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //     return;
                  //   }
                  // }

                  if (selectedTabIndex < tabItems.length - 1) {
                    setState(() {
                      if (selectedTabIndex == 0 &&
                          (_selectedInspectionType?.id == 3 ||
                              _selectedInspectionType?.id == 5 ||
                              _selectedInspectionType?.id == 6)) {
                        selectedTabIndex += 2;
                      } else {
                        selectedTabIndex++;
                      }
                    });
                  } else {
                    // Final step reached – handle final submission here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("All steps completed!")),
                    );
                  }
                } catch (e, stackTrace) {
                  print("Error during onsave :$e");
                  print(stackTrace);
                }
              },
              isSaveEnable: true,
            )
          : null,
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyTabBarDelegate({required this.child});

  @override
  double get minExtent => 70;
  @override
  double get maxExtent => 70;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(elevation: overlapsContent ? 4 : 0, child: child);
  }

  @override
  bool shouldRebuild(covariant _StickyTabBarDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
