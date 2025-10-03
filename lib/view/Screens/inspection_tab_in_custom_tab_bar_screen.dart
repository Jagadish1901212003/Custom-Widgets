import 'dart:io';

import 'package:custom_widgets/custom_widget/core/date_time_field_widget.dart';
import 'package:custom_widgets/custom_widget/core/dropdown_list_widget.dart';
import 'package:custom_widgets/custom_widget/core/expansion_widget.dart';
import 'package:custom_widgets/custom_widget/core/field_label_widget.dart';
import 'package:custom_widgets/custom_widget/core/multiselect_dropdown_widget.dart';
import 'package:custom_widgets/custom_widget/core/radio_button_widget.dart';
import 'package:custom_widgets/custom_widget/core/search_dropdown_widget.dart';
import 'package:custom_widgets/custom_widget/core/text_area_widget.dart';
import 'package:custom_widgets/custom_widget/core/time_field_widget.dart';
import 'package:custom_widgets/model/dropdown_item_model.dart';
import 'package:custom_widgets/model/employee_model.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/enum.dart';
import 'package:custom_widgets/utility/global_tabs.dart';
import 'package:custom_widgets/utility/pop_up_dialog_utility.dart';
import 'package:custom_widgets/view/Screens/NA%20attachment%20_section_for_radio_btn.dart';
import 'package:custom_widgets/view/Screens/ca_description_screen.dart';
import 'package:custom_widgets/view/Screens/document_and_photo_upload_widget.dart';
import 'package:custom_widgets/view/Screens/search_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'globals.dart';
import 'package:custom_widgets/view/Screens/pids_form_.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class InspectionTabInCustomTabBarScreen extends StatefulWidget {
  final DropdownItemModel? selectedInspectionType;
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormState> formKey2;

  const InspectionTabInCustomTabBarScreen({
    super.key,
    required this.selectedInspectionType,
    required this.formKey,
    required this.formKey2,
  });

  @override
  State<InspectionTabInCustomTabBarScreen> createState() =>
      InspectionTabInCustomTabBarScreenState();
}

class InspectionTabInCustomTabBarScreenState
    extends State<InspectionTabInCustomTabBarScreen> {
  // Question 1
  final String waterManagementQ1DocumentsKey = "waterManagement_q1_documents";
  final String waterManagementQ1PhotosKey = "waterManagement_q1_photos";

  // Question 2
  final String waterManagementQ2DocumentsKey = "waterManagement_q2_documents";
  final String waterManagementQ2PhotosKey = "waterManagement_q2_photos";

  // Question 3
  final String waterManagementQ3DocumentsKey = "waterManagement_q3_documents";
  final String waterManagementQ3PhotosKey = "waterManagement_q3_photos";

  // Question 4
  final String waterManagementQ4DocumentsKey = "waterManagement_q4_documents";
  final String waterManagementQ4PhotosKey = "waterManagement_q4_photos";

  // Question 5
  final String waterManagementQ5DocumentsKey = "waterManagement_q5_documents";
  final String waterManagementQ5PhotosKey = "waterManagement_q5_photos";

  // Question 6
  final String waterManagementQ6DocumentsKey = "waterManagement_q6_documents";
  final String waterManagementQ6PhotosKey = "waterManagement_q6_photos";

  // Question 7
  final String waterManagementQ7DocumentsKey = "waterManagement_q7_documents";
  final String waterManagementQ7PhotosKey = "waterManagement_q7_photos";

  // Question 8
  final String waterManagementQ8DocumentsKey = "waterManagement_q8_documents";
  final String waterManagementQ8PhotosKey = "waterManagement_q8_photos";

  // Question 1
  final String siteConditionsQ1DocumentsKey = "siteConditions_q1_documents";
  final String siteConditionsQ1PhotosKey = "siteConditions_q1_photos";

  // Question 2
  final String siteConditionsQ2DocumentsKey = "siteConditions_q2_documents";
  final String siteConditionsQ2PhotosKey = "siteConditions_q2_photos";

  // Question 3
  final String siteConditionsQ3DocumentsKey = "siteConditions_q3_documents";
  final String siteConditionsQ3PhotosKey = "siteConditions_q3_photos";

  // Unique storage keys
  // Question 1
  final String screen1Q1DocumentsKey = "screen1_q1_documents";
  final String screen1Q1PhotosKey = "screen1_q1_photos";

  // Question 2
  final String screen1Q2DocumentsKey = "screen1_q2_documents";
  final String screen1Q2PhotosKey = "screen1_q2_photos";

  // Question 3
  final String screen1Q3DocumentsKey = "screen1_q3_documents";
  final String screen1Q3PhotosKey = "screen1_q3_photos";

  // Question 4
  final String screen1Q4DocumentsKey = "screen1_q4_documents";
  final String screen1Q4PhotosKey = "screen1_q4_photos";

  // Question 5
  final String screen1Q5DocumentsKey = "screen1_q5_documents";
  final String screen1Q5PhotosKey = "screen1_q5_photos";

  // Question 6
  final String screen1Q6DocumentsKey = "screen1_q6_documents";
  final String screen1Q6PhotosKey = "screen1_q6_photos";

  // Question 7
  final String screen1Q7DocumentsKey = "screen1_q7_documents";
  final String screen1Q7PhotosKey = "screen1_q7_photos";

  // Question 8
  final String screen1Q8DocumentsKey = "screen1_q8_documents";
  final String screen1Q8PhotosKey = "screen1_q8_photos";

  // Question 9
  final String screen1Q9DocumentsKey = "screen1_q9_documents";
  final String screen1Q9PhotosKey = "screen1_q9_photos";

  List<DropdownItemModel> selectedItemsOnsite = [];

  // ---------------- Site Conditions & Housekeeping ----------------
  List<File> housekeepingQ1Docs = [];
  List<File> housekeepingQ1Photos = [];
  List<File> housekeepingQ2Docs = [];
  List<File> housekeepingQ2Photos = [];
  List<File> housekeepingQ3Docs = [];
  List<File> housekeepingQ3Photos = [];

  // ---------------- Water Management (8 Questions) ----------------
  List<File> waterManagementQ1Docs = [];
  List<File> waterManagementQ1Photos = [];
  List<File> waterManagementQ2Docs = [];
  List<File> waterManagementQ2Photos = [];
  List<File> waterManagementQ3Docs = [];
  List<File> waterManagementQ3Photos = [];
  List<File> waterManagementQ4Docs = [];
  List<File> waterManagementQ4Photos = [];
  List<File> waterManagementQ5Docs = [];
  List<File> waterManagementQ5Photos = [];
  List<File> waterManagementQ6Docs = [];
  List<File> waterManagementQ6Photos = [];
  List<File> waterManagementQ7Docs = [];
  List<File> waterManagementQ7Photos = [];
  List<File> waterManagementQ8Docs = [];
  List<File> waterManagementQ8Photos = [];

  // ---------------- Erosion and Sediment Control (9 Questions) ----------------
  List<File> erosionSedimentQ1Docs = [];
  List<File> erosionSedimentQ1Photos = [];
  List<File> erosionSedimentQ2Docs = [];
  List<File> erosionSedimentQ2Photos = [];
  List<File> erosionSedimentQ3Docs = [];
  List<File> erosionSedimentQ3Photos = [];
  List<File> erosionSedimentQ4Docs = [];
  List<File> erosionSedimentQ4Photos = [];
  List<File> erosionSedimentQ5Docs = [];
  List<File> erosionSedimentQ5Photos = [];
  List<File> erosionSedimentQ6Docs = [];
  List<File> erosionSedimentQ6Photos = [];
  List<File> erosionSedimentQ7Docs = [];
  List<File> erosionSedimentQ7Photos = [];
  List<File> erosionSedimentQ8Docs = [];
  List<File> erosionSedimentQ8Photos = [];
  List<File> erosionSedimentQ9Docs = [];
  List<File> erosionSedimentQ9Photos = [];

  Position? currentLocation;
  String? currentAddress;

  DropdownItemModel? selectedSiteType;
  DropdownItemModel? selectedWeatherStatus;
  DropdownItemModel? selectedWind;
  DropdownItemModel? selectedGroundCondition;
  DropdownItemModel? selectedConstructionStatus;

  DropdownItemModel? selectedEnvironmentalIncident;

  List<Map<String, String>> pidList = [];
  // Selected value variable
  DropdownItemModel? selectedValuePropertyReview1;

  DropdownItemModel? selectedValuestressedVegetation;
  DropdownItemModel? selectedValueIssueIdentified;

  DropdownItemModel? selectedValueInterview;

  DropdownItemModel? selectedValueSoilStainingObserved;

  // Radio button options
  final List<DropdownItemModel> propertyReviewRadioBtn1 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Unknown", value: 3),
  ];

  final List<DropdownItemModel> interviewRadioBtn1 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
  ];
  final List<DropdownItemModel> stressedVegetationRadioBtn1 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
  ];
  final List<DropdownItemModel> issueIdentifiedRadioBtn = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
  ];
  final List<DropdownItemModel> soilStainingObservedRadioBtn = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
  ];

  final TextEditingController reviewCompletedByController =
      TextEditingController();

  final TextEditingController temperatureController = TextEditingController();

  final TextEditingController siteNameController = TextEditingController();
  final TextEditingController dateOfEventController = TextEditingController();
  final TextEditingController timeOfEventController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  final TextEditingController totalPropertySizeController =
      TextEditingController();
  final TextEditingController issueIdentifiedController =
      TextEditingController();

  final TextEditingController interviewController = TextEditingController();

  final TextEditingController fillController = TextEditingController();

  final TextEditingController
  erosionAndSedimentControlInESCInspectionController1 = TextEditingController();
  final TextEditingController
  erosionAndSedimentControlInESCInspectionController2 = TextEditingController();
  final TextEditingController
  erosionAndSedimentControlInESCInspectionController3 = TextEditingController();
  final TextEditingController
  erosionAndSedimentControlInESCInspectionController4 = TextEditingController();
  final TextEditingController
  erosionAndSedimentControlInESCInspectionController5 = TextEditingController();
  final TextEditingController
  erosionAndSedimentControlInESCInspectionController6 = TextEditingController();
  final TextEditingController
  erosionAndSedimentControlInESCInspectionController7 = TextEditingController();
  final TextEditingController
  erosionAndSedimentControlInESCInspectionController8 = TextEditingController();
  final TextEditingController
  erosionAndSedimentControlInESCInspectionController9 = TextEditingController();

  final TextEditingController waterManagementInESCInspectionController1 =
      TextEditingController();
  final TextEditingController waterManagementInESCInspectionController2 =
      TextEditingController();
  final TextEditingController waterManagementInESCInspectionController3 =
      TextEditingController();
  final TextEditingController waterManagementInESCInspectionController4 =
      TextEditingController();
  final TextEditingController waterManagementInESCInspectionController5 =
      TextEditingController();
  final TextEditingController waterManagementInESCInspectionController6 =
      TextEditingController();
  final TextEditingController waterManagementInESCInspectionController7 =
      TextEditingController();
  final TextEditingController waterManagementInESCInspectionController8 =
      TextEditingController();

  final GlobalState _globalState = GlobalState();
  DateTime now = DateTime.now();

  List<DropdownItemModel> siteTypes = [
    DropdownItemModel(id: 1, name: "Active Construction", value: 1),
    DropdownItemModel(id: 2, name: "Active Facility", value: 2),
    DropdownItemModel(id: 3, name: "Closed Facility", value: 3),
    DropdownItemModel(id: 4, name: "Post Construction", value: 4),
    DropdownItemModel(id: 5, name: "Pre Construction", value: 5),
    DropdownItemModel(id: 6, name: "Other", value: 6),
  ];
  List<DropdownItemModel> constructionStatus = [
    DropdownItemModel(id: 1, name: "Active Construction", value: 1),
    DropdownItemModel(id: 2, name: "Other", value: 2),
    DropdownItemModel(id: 3, name: "Closed Facility", value: 3),
    DropdownItemModel(id: 4, name: "Post Construction", value: 4),
    DropdownItemModel(id: 5, name: "Pre Construction", value: 5),
  ];
  List<DropdownItemModel> weatherStatus = [
    DropdownItemModel(id: 1, name: "Clear", value: 1),
    DropdownItemModel(id: 2, name: "Cloudy", value: 2),
    DropdownItemModel(id: 3, name: "Fog", value: 3),
    DropdownItemModel(id: 4, name: "Rain", value: 4),
    DropdownItemModel(id: 5, name: "Snow", value: 5),
    DropdownItemModel(id: 6, name: "Sun & Cloud", value: 6),
  ];

  List<DropdownItemModel> groundCondition = [
    DropdownItemModel(id: 1, name: "Dry", value: 1),
    DropdownItemModel(id: 2, name: "Frozen", value: 2),
    DropdownItemModel(id: 3, name: "Ice Covered", value: 3),
    DropdownItemModel(id: 4, name: "Snow Covered", value: 4),
    DropdownItemModel(id: 5, name: "Spring freshet(melt)", value: 5),
    DropdownItemModel(id: 6, name: "Wet", value: 6),
  ];
  List<DropdownItemModel> wind = [
    DropdownItemModel(id: 1, name: "Calm", value: 1),
    DropdownItemModel(id: 2, name: "High", value: 2),
    DropdownItemModel(id: 3, name: "Light", value: 3),
    DropdownItemModel(id: 4, name: "Moderate", value: 4),
  ];

  List<DropdownItemModel> environmentalIncidentItems = [
    DropdownItemModel(id: 1, name: "Administrative Control", value: 1),
    DropdownItemModel(id: 2, name: "Archeology", value: 2),
    DropdownItemModel(id: 3, name: "Erosion and Sediment Control", value: 3),
    DropdownItemModel(id: 4, name: "Fuel and Oil Management", value: 4),
    DropdownItemModel(id: 5, name: "Other", value: 5),
    DropdownItemModel(id: 6, name: "Waste Management", value: 6),
    DropdownItemModel(id: 7, name: "Wildlife", value: 7),
  ];

  final List<DropdownItemModel> environmentalSiteRadioBtn1 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Unknown", value: 3),
  ];

  late final List<DropdownItemModel> environmentalSiteRadioBtn2 = [
    ...environmentalSiteRadioBtn1,
  ];
  late final List<DropdownItemModel> environmentalSiteRadioBtn3 = [
    ...environmentalSiteRadioBtn1,
  ];
  late final List<DropdownItemModel> environmentalSiteRadioBtn4 = [
    ...environmentalSiteRadioBtn1,
  ];
  late final List<DropdownItemModel> environmentalSiteRadioBtn5 = [
    ...environmentalSiteRadioBtn1,
  ];
  late final List<DropdownItemModel> environmentalSiteRadioBtn6 = [
    ...environmentalSiteRadioBtn1,
  ];
  late final List<DropdownItemModel> environmentalSiteRadioBtn7 = [
    ...environmentalSiteRadioBtn1,
  ];
  late final List<DropdownItemModel> environmentalSiteRadioBtn8 = [
    ...environmentalSiteRadioBtn1,
  ];
  late final List<DropdownItemModel> environmentalSiteRadioBtn9 = [
    ...environmentalSiteRadioBtn1,
  ];
  late final List<DropdownItemModel> environmentalSiteRadioBtn10 = [
    ...environmentalSiteRadioBtn1,
  ];
  late final List<DropdownItemModel> environmentalSiteRadioBtn11 = [
    ...environmentalSiteRadioBtn1,
  ];
  late final List<DropdownItemModel> environmentalSiteRadioBtn12 = [
    ...environmentalSiteRadioBtn1,
  ];
  late final List<DropdownItemModel> environmentalSiteRadioBtn13 = [
    ...environmentalSiteRadioBtn1,
  ];

  final List<DropdownItemModel> waterManagementInESCInspectionRadioBtn1 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];

  final List<DropdownItemModel> waterManagementInESCInspectionRadioBtn2 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];

  final List<DropdownItemModel> waterManagementInESCInspectionRadioBtn3 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];

  final List<DropdownItemModel> waterManagementInESCInspectionRadioBtn4 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];

  final List<DropdownItemModel> waterManagementInESCInspectionRadioBtn5 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];

  final List<DropdownItemModel> waterManagementInESCInspectionRadioBtn6 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];

  final List<DropdownItemModel> waterManagementInESCInspectionRadioBtn7 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];

  final List<DropdownItemModel> waterManagementInESCInspectionRadioBtn8 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];

  final List<DropdownItemModel>
  erosionAndSedimentControlInESCInspectionRadioBtn1 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];
  final List<DropdownItemModel>
  erosionAndSedimentControlInESCInspectionRadioBtn2 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];
  final List<DropdownItemModel>
  erosionAndSedimentControlInESCInspectionRadioBtn3 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];
  final List<DropdownItemModel>
  erosionAndSedimentControlInESCInspectionRadioBtn4 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];
  final List<DropdownItemModel>
  erosionAndSedimentControlInESCInspectionRadioBtn5 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];
  final List<DropdownItemModel>
  erosionAndSedimentControlInESCInspectionRadioBtn6 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];
  final List<DropdownItemModel>
  erosionAndSedimentControlInESCInspectionRadioBtn7 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];
  final List<DropdownItemModel>
  erosionAndSedimentControlInESCInspectionRadioBtn8 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];
  final List<DropdownItemModel>
  erosionAndSedimentControlInESCInspectionRadioBtn9 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];

  final List<DropdownItemModel> administrativeControlsRadioBtn1 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> administrativeControlsRadioBtn2 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> administrativeControlsRadioBtn3 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> administrativeControlsRadioBtn4 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];

  final List<DropdownItemModel> erosionAndSedimentControlRadioBtn1 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> erosionAndSedimentControlRadioBtn2 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> erosionAndSedimentControlRadioBtn3 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> erosionAndSedimentControlRadioBtn4 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> erosionAndSedimentControlRadioBtn5 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> erosionAndSedimentControlRadioBtn6 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> erosionAndSedimentControlRadioBtn7 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> erosionAndSedimentControlRadioBtn8 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];

  final List<DropdownItemModel> fuelAndOilManagementRadioBtn1 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> fuelAndOilManagementRadioBtn2 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> fuelAndOilManagementRadioBtn3 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> fuelAndOilManagementRadioBtn4 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];

  final List<DropdownItemModel> wasteManagementRadioBtn1 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> wasteManagementRadioBtn2 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> wasteManagementRadioBtn3 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];

  final List<DropdownItemModel> wildlifeRadioBtn1 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> wildlifeRadioBtn2 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> wildlifeRadioBtn3 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];

  final List<DropdownItemModel> airQualityManagementRadioBtn1 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> airQualityManagementRadioBtn2 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];
  final List<DropdownItemModel> airQualityManagementRadioBtn3 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];

  final List<DropdownItemModel> archaeologyRadioBtn1 = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
    DropdownItemModel(id: 3, name: "Not Applicable", value: 3),
  ];

  final List<DropdownItemModel> environmentalInspectionRadioBtn = [
    DropdownItemModel(id: 1, name: "Yes", value: 1),
    DropdownItemModel(id: 2, name: "No", value: 2),
  ];

  DropdownItemModel? selectedValueErosionAndSedimentControlInESCInspection1;
  DropdownItemModel? selectedValueErosionAndSedimentControlInESCInspection2;
  DropdownItemModel? selectedValueErosionAndSedimentControlInESCInspection3;
  DropdownItemModel? selectedValueErosionAndSedimentControlInESCInspection4;
  DropdownItemModel? selectedValueErosionAndSedimentControlInESCInspection5;
  DropdownItemModel? selectedValueErosionAndSedimentControlInESCInspection6;
  DropdownItemModel? selectedValueErosionAndSedimentControlInESCInspection7;
  DropdownItemModel? selectedValueErosionAndSedimentControlInESCInspection8;
  DropdownItemModel? selectedValueErosionAndSedimentControlInESCInspection9;

  DropdownItemModel? selectedValueWaterManagementInESCInspection1;
  DropdownItemModel? selectedValueWaterManagementInESCInspection2;
  DropdownItemModel? selectedValueWaterManagementInESCInspection3;
  DropdownItemModel? selectedValueWaterManagementInESCInspection4;
  DropdownItemModel? selectedValueWaterManagementInESCInspection5;
  DropdownItemModel? selectedValueWaterManagementInESCInspection6;
  DropdownItemModel? selectedValueWaterManagementInESCInspection7;
  DropdownItemModel? selectedValueWaterManagementInESCInspection8;

  DropdownItemModel? selectedValueEnvironmentalSite1;
  DropdownItemModel? selectedValueEnvironmentalSite2;
  DropdownItemModel? selectedValueEnvironmentalSite3;
  DropdownItemModel? selectedValueEnvironmentalSite4;
  DropdownItemModel? selectedValueEnvironmentalSite5;
  DropdownItemModel? selectedValueEnvironmentalSite6;
  DropdownItemModel? selectedValueEnvironmentalSite7;
  DropdownItemModel? selectedValueEnvironmentalSite8;
  DropdownItemModel? selectedValueEnvironmentalSite9;
  DropdownItemModel? selectedValueEnvironmentalSite10;
  DropdownItemModel? selectedValueEnvironmentalSite11;
  DropdownItemModel? selectedValueEnvironmentalSite12;
  DropdownItemModel? selectedValueEnvironmentalSite13;

  DropdownItemModel? selectedValueAdministratorControls1;
  DropdownItemModel? selectedValueAdministratorControls2;
  DropdownItemModel? selectedValueAdministratorControls3;
  DropdownItemModel? selectedValueAdministratorControls4;

  DropdownItemModel? selectedValueErosionAndSedimentControl1;
  DropdownItemModel? selectedValueErosionAndSedimentControl2;
  DropdownItemModel? selectedValueErosionAndSedimentControl3;
  DropdownItemModel? selectedValueErosionAndSedimentControl4;
  DropdownItemModel? selectedValueErosionAndSedimentControl5;
  DropdownItemModel? selectedValueErosionAndSedimentControl6;
  DropdownItemModel? selectedValueErosionAndSedimentControl7;
  DropdownItemModel? selectedValueErosionAndSedimentControl8;

  DropdownItemModel? selectedValueFuelAndOilManagement1;
  DropdownItemModel? selectedValueFuelAndOilManagement2;
  DropdownItemModel? selectedValueFuelAndOilManagement3;
  DropdownItemModel? selectedValueFuelAndOilManagement4;

  DropdownItemModel? selectedValueWasteManagement1;
  DropdownItemModel? selectedValueWasteManagement2;
  DropdownItemModel? selectedValueWasteManagement3;

  DropdownItemModel? selectedValueWildlife1;
  DropdownItemModel? selectedValueWildlife2;
  DropdownItemModel? selectedValueWildlife3;

  DropdownItemModel? selectedValueairQualityManagement1;
  DropdownItemModel? selectedValueairQualityManagement2;
  DropdownItemModel? selectedValueairQualityManagement3;

  DropdownItemModel? selectedValueArchaeology1;

  DropdownItemModel? selectedValueEnvironmentalInspection;

  bool hasSelectedInspectionType = false;
  bool _erosionAndSedimentControlInESCInspectionIsChecked = false;
  bool _waterManagementInESCInspectionIsChecked = false;

  bool _administratorControlsIsChecked = false;
  bool _erosionAndSedimentControlIsChecked = false; // tracks checkbox state
  bool _fuelAndOilManagementIsChecked = false; // tracks checkbox state
  bool _wasteManagementIsChecked = false; // tracks checkbox state
  bool _wildlifeIsChecked = false; // tracks checkbox state
  bool _airQualityManagementIsChecked = false; // tracks checkbox state
  bool _archaeologyIsChecked = false;

  // Checkbox state
  bool _siteConditionsHousekeepingIsChecked = false;

  // Selected values
  DropdownItemModel? selectedValueSiteConditionsHousekeeping1;
  DropdownItemModel? selectedValueSiteConditionsHousekeeping2;
  DropdownItemModel? selectedValueSiteConditionsHousekeeping3;

  // Dropdown radio items
  final List<DropdownItemModel> siteConditionsHousekeepingRadioBtn1 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];
  final List<DropdownItemModel> siteConditionsHousekeepingRadioBtn2 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];
  final List<DropdownItemModel> siteConditionsHousekeepingRadioBtn3 = [
    DropdownItemModel(id: 1, name: "Adequate", value: 1),
    DropdownItemModel(id: 2, name: "Improvement in Progress", value: 2),
    DropdownItemModel(id: 3, name: "Needs Improvement", value: 3),
    DropdownItemModel(id: 4, name: "Not Applicable", value: 4),
  ];

  // Text controllers
  final TextEditingController siteConditionsHousekeepingController1 =
      TextEditingController();
  final TextEditingController siteConditionsHousekeepingController2 =
      TextEditingController();
  final TextEditingController siteConditionsHousekeepingController3 =
      TextEditingController();

  DropdownItemModel? selectedPropertyReviewTypeType;
  DropdownItemModel? selectedPropertyZoning;

  DropdownItemModel? _selectedPropertyUse;

  final List<DropdownItemModel> propertyReviewType = [
    DropdownItemModel(id: 1, name: "Desktop Only", value: 1),
    DropdownItemModel(id: 2, name: "Onsite", value: 2),
  ];
  final List<DropdownItemModel> propertyZoning = [
    DropdownItemModel(id: 1, name: "Commercial", value: 1),
    DropdownItemModel(id: 2, name: "Other", value: 2),
    DropdownItemModel(id: 3, name: "Residential", value: 3),
    DropdownItemModel(id: 4, name: "Resource", value: 4),
    DropdownItemModel(id: 5, name: "Resource Farm", value: 5),
    DropdownItemModel(id: 6, name: "Resource Forest", value: 6),
  ];
  final List<DropdownItemModel> propertyUse = [
    DropdownItemModel(id: 1, name: "Agricultural", value: 1),
    DropdownItemModel(id: 2, name: "Clean Fill Site", value: 2),
    DropdownItemModel(id: 3, name: "Commercial", value: 3),
    DropdownItemModel(id: 4, name: "Dump Site", value: 4),
    DropdownItemModel(id: 5, name: "Other", value: 5),
    DropdownItemModel(id: 6, name: "Pit and/or Quarry", value: 6),
    DropdownItemModel(id: 7, name: "Residential", value: 7),
    DropdownItemModel(id: 8, name: "Vacant Lot", value: 8),
  ];

  bool isAddEnabled = false;

  void isAddEnable(DropdownItemModel? selected) {
    isAddEnabled = false;
    if (selected == selectedPropertyReviewTypeType) {
      if (selectedPropertyReviewTypeType != null) {
        isAddEnabled = true;
      }
    } else if (selected == selectedPropertyZoning) {
      if (selectedPropertyZoning != null) {
        isAddEnabled = true;
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    _globalState.incidentDetails.basicDetailsModel?.dateOfIncReported =
        DateFormat('yyyy-MM-dd').format(now);
    _globalState.incidentDetails.basicDetailsModel?.timeOfIncReported =
        DateFormat('HH:mm:ss').format(now);
    super.initState();
  }

  // bool validateInspectionTab() {
  void validateInspectionTab() {
    List<String> errors = [];

    // if (siteNameController.text.trim().isEmpty) {
    //   errors.add("Site Name is required.");
    // }

    if (dateOfEventController.text.trim().isEmpty) {
      errors.add("Inspection Date is required.");
    }

    if (timeOfEventController.text.trim().isEmpty) {
      errors.add("Inspection time is required.");
    }

    // if (locationController.text.trim().isEmpty) {
    //   errors.add("Location is required.");
    // }
  }

  final List<DropdownItemModel> siteActivityDropdownItems = [
    DropdownItemModel(id: 1, name: 'Active Job Site', value: 1),
    DropdownItemModel(id: 2, name: 'Asphalt Plant', value: 2),
    DropdownItemModel(id: 3, name: 'C and D facility', value: 3),
    DropdownItemModel(id: 4, name: 'Crushing', value: 4),
    DropdownItemModel(id: 5, name: 'Drilling and Blasting', value: 5),
    DropdownItemModel(id: 6, name: 'Grubbing', value: 6),
    DropdownItemModel(id: 7, name: 'Loading and Hauling', value: 7),
    DropdownItemModel(id: 8, name: 'Municipal Landfill', value: 8),
    DropdownItemModel(id: 9, name: 'No activity', value: 9),
    DropdownItemModel(id: 10, name: 'Other', value: 10),
    DropdownItemModel(id: 11, name: 'Tree Clearing', value: 11),
  ];
  final List<DropdownItemModel> adjoiningPropertyUsesDropdownItems = [
    DropdownItemModel(id: 1, name: 'Commercial', value: 1),
    DropdownItemModel(id: 2, name: 'Dump Site', value: 2),
    DropdownItemModel(id: 3, name: 'Forest Lot', value: 3),
    DropdownItemModel(id: 4, name: 'Industrial', value: 4),
    DropdownItemModel(id: 5, name: 'Pit', value: 5),
    DropdownItemModel(id: 6, name: 'Quarry', value: 6),
    DropdownItemModel(id: 7, name: 'Residential', value: 7),
    DropdownItemModel(id: 8, name: 'Vacant Lot', value: 8),
  ];

  final List<DropdownItemModel> itemsOnsiteDropdownItems = [
    DropdownItemModel(id: 1, name: 'Forest Area', value: 1),
    DropdownItemModel(id: 2, name: 'On-site Sewage System', value: 2),
    DropdownItemModel(id: 3, name: 'On-site Stormwater System', value: 3),
    DropdownItemModel(id: 4, name: 'Pits', value: 4),
    DropdownItemModel(id: 5, name: 'Potable Water Supply', value: 5),
    DropdownItemModel(
      id: 6,
      name: 'Potable Water Supply - Municipal',
      value: 6,
    ),
    DropdownItemModel(id: 7, name: 'Storage Tanks', value: 7),
    DropdownItemModel(id: 8, name: 'Structures', value: 8),
    DropdownItemModel(id: 9, name: 'Water', value: 9),
    DropdownItemModel(id: 10, name: 'Wetland/Potential Wetland', value: 10),
  ];

  final List<DropdownItemModel> sampleTypeDropdownItems = [
    DropdownItemModel(id: 1, name: 'Ground Water', value: 1),
    DropdownItemModel(id: 2, name: 'Other', value: 2),
    DropdownItemModel(id: 3, name: 'Potable Water', value: 3),
    DropdownItemModel(id: 4, name: 'Rock', value: 4),
    DropdownItemModel(id: 5, name: 'Sediment', value: 5),
    DropdownItemModel(id: 6, name: 'Soil', value: 6),
    DropdownItemModel(id: 7, name: 'Surface Water', value: 7),
  ];
  EmployeeModel? loginUser;
  EmployeeModel? reportedByDetails2;

  void reviewCompletedBy(EmployeeModel user) {
    reportedByDetails2 = user;
    reviewCompletedByController.text = user.empName;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          // section 1
          Column(
            children: [
              Padding(
                // padding: const EdgeInsets.symmetric(
                //   vertical: 3,
                //   horizontal: 15,
                // ),
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 5,
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // color: Colors.white,
                  // elevation: 4,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(8),
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
                      children: [
                        // Padding(
                        // padding: const EdgeInsets.only(left: 0, right: 00),
                        // child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (widget.selectedInspectionType?.name !=
                                    "Property Review")
                                ? TextAreaWidget(
                                    padding: EdgeInsets.all(0),
                                    minLines: 2,
                                    height: 60,
                                    isRequired: true,
                                    // keyboardType: TextInputType.number,
                                    hintText: "Maximum charcter limit is 100",
                                    controller: siteNameController,
                                    lable: "Site Name",
                                    onChange: (value) {},
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const FieldLableWidget(
                                        // padding: EdgeInsets.only(left: 15),
                                        lable: "Property Review Type",
                                        isRequired: true,
                                      ),
                                      DropdownListWidget(
                                        hintText: "Property Review Type",
                                        // selected: ,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 0,
                                        ),
                                        selected:
                                            selectedPropertyReviewTypeType,

                                        isRequired: true,
                                        // margin: const EdgeInsets.all(0),
                                        items: propertyReviewType,
                                        onChange: (value) async {
                                          selectedPropertyReviewTypeType =
                                              value;
                                          // isAddEnable(
                                          //   selectedPropertyReviewTypeType,
                                          // );
                                        },
                                      ),
                                    ],
                                  ),
                            if (widget.selectedInspectionType?.name !=
                                "Property Review")
                              const FieldLableWidget(
                                lable: "Inspection Date",
                                isRequired: true,
                              ),
                            if (widget.selectedInspectionType?.name !=
                                "Property Review")
                              DateTimeFieldWidget(
                                key: Key(DateTime.now().toString()),
                                isRequired: true,
                                selectedDate: _globalState
                                    .incidentDetails
                                    .basicDetailsModel
                                    ?.incidentDate,
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
                            if (widget.selectedInspectionType?.name !=
                                "Property Review")
                              const FieldLableWidget(
                                lable: "Inspection Time",
                                isRequired: true,
                              ),
                            if (widget.selectedInspectionType?.name !=
                                "Property Review")
                              TimeFieldWidget(
                                isRequired: true,
                                timeController: timeOfEventController,
                                hintText: 'Select time',
                                onTimeSelect: (time) async {
                                  timeOfEventController.text = time;
                                },
                              ),

                            (widget.selectedInspectionType?.name !=
                                    "Property Review")
                                ? (widget.selectedInspectionType?.name !=
                                              "ESC Inspection" &&
                                          widget.selectedInspectionType?.name !=
                                              "Sample Collection")
                                      ? FieldLableWidget(
                                          lable: "Site Type",
                                          isRequired:
                                              (widget
                                                      .selectedInspectionType
                                                      ?.name !=
                                                  "Environmental Site Evaluation")
                                              ? false
                                              : true,
                                        )
                                      : FieldLableWidget(
                                          lable: "Construction Status",
                                          isRequired:
                                              (widget
                                                      .selectedInspectionType
                                                      ?.name ==
                                                  "Sample Collection")
                                              ? true
                                              : false,
                                        )
                                : const SizedBox.shrink(), // renders nothing if name == "Property Review"

                            (widget.selectedInspectionType?.name !=
                                    "Property Review")
                                ? (widget.selectedInspectionType?.name !=
                                              "ESC Inspection" &&
                                          widget.selectedInspectionType?.name !=
                                              "Sample Collection")
                                      ? DropdownListWidget(
                                          // selected: ,
                                          margin: EdgeInsets.symmetric(
                                            // horizontal: 15,
                                          ),
                                          selected: selectedSiteType,

                                          isRequired: false,
                                          // margin: const EdgeInsets.all(0),
                                          items: siteTypes,

                                          // },
                                          onChange: (value) async {
                                            selectedSiteType = value;
                                            // isAddEnable();
                                          },
                                        )
                                      : DropdownListWidget(
                                          // selected: ,
                                          margin: EdgeInsets.symmetric(
                                            // horizontal: 15,
                                          ),
                                          selected: selectedConstructionStatus,

                                          isRequired: false,
                                          // margin: const EdgeInsets.all(0),
                                          items: constructionStatus,

                                          // },
                                          onChange: (value) async {
                                            selectedConstructionStatus = value;
                                            // isAddEnable();
                                          },
                                        )
                                : const SizedBox.shrink(),

                            if (widget.selectedInspectionType?.name !=
                                    "Environmental Site Evaluation" &&
                                widget.selectedInspectionType?.name !=
                                    "Property Review")
                              const FieldLableWidget(
                                lable: "Weather Status",
                                isRequired: false,
                              ),

                            if (widget.selectedInspectionType?.name !=
                                    "Environmental Site Evaluation" &&
                                widget.selectedInspectionType?.name !=
                                    "Property Review")
                              DropdownListWidget(
                                margin: EdgeInsets.symmetric(
                                  // horizontal: 15
                                ),
                                selected: selectedWeatherStatus,

                                isRequired: false,
                                items: weatherStatus,
                                onChange: (value) async {
                                  selectedWeatherStatus = value;
                                  // isAddEnable();
                                },
                              ),

                            // Temperature
                            if (widget.selectedInspectionType?.name !=
                                    "Property Review" &&
                                widget.selectedInspectionType?.name !=
                                    "Environmental Site Evaluation")
                              TextAreaWidget(
                                minLines: 1,
                                height: 50,
                                isRequired: false,
                                keyboardType: TextInputType.number,
                                hintText: "°Celsius",
                                controller: temperatureController,
                                lable: "Temperature",
                                onChange: (value) {},
                              ),

                            // Site Activity
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.selectedInspectionType?.name ==
                                    "Sample Collection") ...[
                                  const FieldLableWidget(
                                    lable: "Site Activity",
                                  ),
                                  MultiSelectDropDown(
                                    margin: const EdgeInsets.all(0),
                                    searchEnabled: false,
                                    selected: const [], //[emissionType.first],
                                    hintText: 'Site Activity',
                                    items: siteActivityDropdownItems,
                                    onCheck: (value, isSelected) {},
                                    onChange: (value) {},
                                  ),

                                  // Sample Type
                                  const FieldLableWidget(lable: "Sample Type "),
                                  MultiSelectDropDown(
                                    margin: const EdgeInsets.all(0),
                                    searchEnabled: false,
                                    selected: const [], //[emissionType.first],
                                    hintText: 'Sample Type',
                                    items: sampleTypeDropdownItems,
                                    onCheck: (value, isSelected) {},
                                    onChange: (value) {},
                                  ),
                                ],
                              ],
                            ),

                            // wind
                            if (widget.selectedInspectionType?.name !=
                                    "Environmental Site Evaluation" &&
                                widget.selectedInspectionType?.name !=
                                    "Property Review" &&
                                widget.selectedInspectionType?.name !=
                                    "Sample Collection")
                              const FieldLableWidget(
                                lable: "Wind",
                                isRequired: false,
                              ),

                            if (widget.selectedInspectionType?.name !=
                                    "Environmental Site Evaluation" &&
                                widget.selectedInspectionType?.name !=
                                    "Property Review" &&
                                widget.selectedInspectionType?.name !=
                                    "Sample Collection")
                              DropdownListWidget(
                                margin: EdgeInsets.symmetric(
                                  // horizontal: 15
                                ),
                                selected: selectedWind,

                                isRequired: false,
                                items: wind,
                                onChange: (value) async {
                                  selectedWind = value;
                                  // isAddEnable();
                                },
                              ),

                            // Ground Condition
                            if (widget.selectedInspectionType?.name !=
                                    "Environmental Site Evaluation" &&
                                widget.selectedInspectionType?.name !=
                                    "Property Review")
                              const FieldLableWidget(
                                lable: "Ground Condition",
                                isRequired: false,
                              ),

                            if (widget.selectedInspectionType?.name !=
                                    "Environmental Site Evaluation" &&
                                widget.selectedInspectionType?.name !=
                                    "Property Review")
                              DropdownListWidget(
                                margin: EdgeInsets.symmetric(
                                  // horizontal: 15
                                ),
                                selected: selectedGroundCondition,

                                isRequired: false,
                                items: groundCondition,
                                onChange: (value) async {
                                  selectedGroundCondition = value;
                                  // isAddEnable();
                                },
                              ),

                            const SizedBox(height: 10),

                            // Review Completed By
                            if (widget.selectedInspectionType?.name ==
                                "Property Review")
                              const FieldLableWidget(
                                lable: "Review Completed By",
                                isRequired: true,
                                // padding: EdgeInsets.only(left: 15),
                              ),
                            if (widget.selectedInspectionType?.name ==
                                "Property Review")
                              SearchDropdownWidget(
                                // //padding: EdgeInsets.symmetric(horizontal: 15),
                                controller: reviewCompletedByController,
                                icon: Icon(Icons.contact_page),
                                isRequired: true,
                                hintText: 'Review Completed By',
                                onTap: () {
                                  Navigator.push<EmployeeModel>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const SearchEmployeeScreen(
                                            title: 'Review Completed By',
                                          ),
                                    ),
                                  ).then((selectedEmployee) {
                                    if (selectedEmployee != null) {
                                      if (loginUser?.empId ==
                                          selectedEmployee.empId) {
                                        PopUpDialogUtility.showAlertDialogSystem(
                                          context: context,
                                          popupTitle: 'Warning',
                                          description:
                                              "Reporting Person cannot be the same as the Incident Entered By.",
                                        );
                                        return;
                                      }
                                      reviewCompletedBy(selectedEmployee);
                                    }
                                  });
                                },
                              ),
                            // const SizedBox(height: 10),

                            // Location
                            TextAreaWidget(
                              height: 100,
                              isRequired: true,
                              // keyboardType: TextInputType.number,
                              hintText:
                                  "Maximum charcter limit is 500 charcters",
                              controller: locationController,
                              lable: "Location",
                              onChange: (value) {},
                            ),
                            SizedBox(height: 10),

                            Container(
                              // elevation: 4,
                              color: Colors.white,

                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(8),
                              // ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          bool serviceEnabled;
                                          LocationPermission permission;

                                          // Check if location service is enabled
                                          serviceEnabled =
                                              await Geolocator.isLocationServiceEnabled();
                                          if (!serviceEnabled) {
                                            return;
                                          }

                                          // Check for permissions
                                          permission =
                                              await Geolocator.checkPermission();
                                          if (permission ==
                                              LocationPermission.denied) {
                                            permission =
                                                await Geolocator.requestPermission();
                                            if (permission ==
                                                LocationPermission.denied) {
                                              return;
                                            }
                                          }

                                          if (permission ==
                                              LocationPermission
                                                  .deniedForever) {
                                            return;
                                          }

                                          // Fetch current location
                                          currentLocation =
                                              await Geolocator.getCurrentPosition(
                                                desiredAccuracy:
                                                    LocationAccuracy.high,
                                              );

                                          print(
                                            "Latitude: ${currentLocation?.latitude}, Longitude: ${currentLocation?.longitude}",
                                          );

                                          // Reverse geocode into address
                                          if (currentLocation != null) {
                                            try {
                                              List<Placemark> placemarks =
                                                  await placemarkFromCoordinates(
                                                    currentLocation!.latitude,
                                                    currentLocation!.longitude,
                                                  );

                                              if (placemarks.isNotEmpty) {
                                                Placemark place = placemarks[0];
                                                currentAddress =
                                                    "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";

                                                print(
                                                  "Address: $currentAddress",
                                                );

                                                setState(() {
                                                  locationController =
                                                      TextEditingController(
                                                        text: currentAddress,
                                                      );
                                                });
                                              } else {
                                                print(
                                                  "No address found for this location",
                                                );
                                              }
                                            } catch (e) {
                                              print(
                                                "Error fetching address: $e",
                                              );
                                            }
                                          } else {
                                            print("Location not available");
                                          }
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.map,
                                              color: Colors.green,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "Map Location",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // section 2
          // getSelectedWidget(widget.selectedInspectionType?.name),
          // Padding(
          //   padding: const EdgeInsets.all(0),
          //   child:
          getSelectedWidgetInSection2(),
          // ),
        ],
        // ),
      ),
    );
  }

  Widget getSelectedWidgetInSection2() {
    switch (widget.selectedInspectionType?.name) {
      case 'ENV Inspection':
        return envInspectionsection2();
      case 'ESC Inspection':
        return escInsepctionSection2();
      case 'Environmental Site Evaluation':
        return environmentalSiteEvaluationSection2();
      // no need for fish rescue as it can be handle in default
      // case 'Fish Rescue':
      //   return SizedBox();
      case 'Property Review':
        return propertyReviewSection2();
      case 'Sample Collection':
        return sampleCollectionSection2();
      default:
        return SizedBox(); // or any default widget
    }
  }

  Widget propertyReviewSection2() {
    return Column(
      children: [
        // # of PIDs
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                            alignment: AlignmentGeometry.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "# of PIDs",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddPidPage(),
                                      ),
                                    );

                                    if (result != null) {
                                      setState(() {
                                        pidList.add(result);
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Add More',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.appPrimaryColor,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      // vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   itemCount: pidList.length,
                        //   itemBuilder: (context, index) {
                        //     final pid = pidList[index];
                        //     return Card(
                        //       // color: Colors.white,
                        //       elevation: 4,
                        //       margin: EdgeInsets.symmetric(vertical: 8),
                        //       child: ListTile(
                        //         title: Text("PID Number: ${pid['number']}"),
                        //         subtitle: Text("PID Size (ha): ${pid['size']}"),
                        //       ),
                        //     );
                        //   },
                        // ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: pidList.length,
                          itemBuilder: (context, index) {
                            final pid = pidList[index];

                            return Card(
                              elevation: 4,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                onTap: () async {
                                  // Navigate to form with prefilled values
                                  final updatedPid = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddPidPage(
                                        initialNumber: pid['number'],
                                        initialSize: pid['size'],
                                      ),
                                    ),
                                  );

                                  if (updatedPid != null) {
                                    setState(() {
                                      pidList[index] =
                                          updatedPid; // update the edited PID
                                    });
                                  }
                                },
                                title: Text("PID Number: ${pid['number']}"),
                                subtitle: Text("PID Size (ha): ${pid['size']}"),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      pidList.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Total Property Size (ha)
                        TextAreaWidget(
                          height: 75,
                          maxLength: 100,
                          isRequired: false,
                          keyboardType: TextInputType.number,
                          hintText: "Maximum charcter limit is 100",
                          controller: totalPropertySizeController,
                          lable: "Total Property Size (ha)",
                          onChange: (value) {},
                        ),
                        SizedBox(height: 10),
                        const FieldLableWidget(
                          lable: "Property Zoning",
                          isRequired: false,
                        ),
                        DropdownListWidget(
                          hintText: "Property Zoning",
                          margin: EdgeInsets.symmetric(horizontal: 0),
                          selected: selectedPropertyZoning,

                          isRequired: false,
                          // margin: const EdgeInsets.all(0),
                          items: propertyZoning,
                          onChange: (value) async {
                            selectedPropertyZoning = value;
                            // isAddEnable(selectedPropertyZoning);
                          },
                        ),

                        SizedBox(height: 10),

                        const FieldLableWidget(
                          lable: "Property Use",
                          isRequired: true,
                        ),
                        DropdownListWidget(
                          hintText: "Property Use",
                          margin: EdgeInsets.symmetric(horizontal: 0),
                          selected: _selectedPropertyUse,

                          isRequired: true,
                          // margin: const EdgeInsets.all(0),
                          items: propertyUse,
                          onChange: (value) async {
                            _selectedPropertyUse = value;
                            // isAddEnable(selectedPropertyZoning);
                          },
                        ),
                        SizedBox(height: 10),

                        const FieldLableWidget(
                          lable: "Items Onsite",
                          isRequired: true,
                        ),
                        MultiSelectDropDown(
                          isRequired: true,
                          margin: const EdgeInsets.all(0),
                          searchEnabled: false,
                          selected: const [], //[emissionType.first],
                          hintText: 'Items Onsite',
                          items: itemsOnsiteDropdownItems,
                          onCheck: (value, isSelected) {},
                          onChange: (values) {},
                        ),

                        // Keep track of selected items (store models or just names)

                        // Widget
                        // MultiSelectDropDown(
                        //   isRequired: true,
                        //   margin: const EdgeInsets.all(0),
                        //   searchEnabled: false,
                        //   selected: selectedItemsOnsite, // ✅ bind list directly
                        //   hintText: 'Items Onsite',
                        //   items: itemsOnsiteDropdownItems,
                        //   onCheck: (value, isSelected) {
                        //     final item = value as DropdownItemModel;
                        //     setState(() {
                        //       if (isSelected) {
                        //         if (!selectedItemsOnsite.any(
                        //           (e) => e.id == item.id,
                        //         )) {
                        //           selectedItemsOnsite.add(item);
                        //         }
                        //       } else {
                        //         selectedItemsOnsite.removeWhere(
                        //           (e) => e.id == item.id,
                        //         );
                        //       }
                        //     });
                        //   },
                        //   onChange: (values) {
                        //     setState(() {
                        //       selectedItemsOnsite =
                        //           List<DropdownItemModel>.from(values);
                        //     });
                        //   },
                        // ),
                        SizedBox(height: 10),

                        const FieldLableWidget(
                          lable: "Stressed Vegetation",
                          // isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonWidget(
                          radioItems: stressedVegetationRadioBtn1,
                          radioSelectedValue: selectedValuestressedVegetation,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          // isRequired: true,
                          showError: false,
                          onChange: (newValue) async {
                            final selectedItem = newValue as DropdownItemModel;
                            setState(() {
                              selectedValuestressedVegetation = selectedItem;
                            });
                          },
                        ),
                        if (selectedValuestressedVegetation?.name
                                .toLowerCase() ==
                            "yes")
                          SizedBox(height: 10),

                        if (selectedValuestressedVegetation?.name
                                .toLowerCase() ==
                            "yes")
                          TextAreaWidget(
                            height: 75,
                            maxLength: 100,
                            isRequired: false,
                            // keyboardType: TextInputType.number,
                            hintText: "Maximum charcter limit is 100",
                            controller: totalPropertySizeController,
                            lable: "Topographic Conditions",
                            onChange: (value) {},
                          ),
                        SizedBox(height: 10),

                        const FieldLableWidget(
                          lable: "Adjoining Property Uses",
                          isRequired: true,
                        ),
                        MultiSelectDropDown(
                          isRequired: true,
                          margin: const EdgeInsets.all(0),
                          searchEnabled: false,
                          selected: const [], //[emissionType.first],
                          hintText: 'Adjoining Property Uses',
                          items: adjoiningPropertyUsesDropdownItems,
                          onCheck: (value, isSelected) {},
                          onChange: (value) {},
                        ),

                        // Soil Staining Observed
                        SizedBox(height: 10),

                        const FieldLableWidget(
                          lable: "Soil Staining Observed",
                          // isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonWidget(
                          radioItems:
                              soilStainingObservedRadioBtn, // soilStainingObservedRadioBtn
                          radioSelectedValue:
                              selectedValueSoilStainingObserved, // selectedValueSoilStainingObserved
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          // isRequired: true,
                          showError: false,
                          onChange: (newValue) async {
                            final selectedItem = newValue as DropdownItemModel;
                            setState(() {
                              selectedValueSoilStainingObserved = selectedItem;
                            });
                          },
                        ),
                        if (selectedValueSoilStainingObserved?.name
                                .toLowerCase() ==
                            "yes")
                          SizedBox(height: 10),

                        if (selectedValueSoilStainingObserved?.name
                                .toLowerCase() ==
                            "yes")
                          TextAreaWidget(
                            height: 75,
                            maxLength: 100,
                            isRequired: false,
                            // keyboardType: TextInputType.number,
                            hintText: "Maximum charcter limit is 100",
                            controller: fillController,
                            lable: "Fill",
                            onChange: (value) {},
                          ),
                        SizedBox(height: 10),

                        // Interview
                        SizedBox(height: 10),

                        const FieldLableWidget(
                          lable: "Interview",
                          // isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonWidget(
                          radioItems: interviewRadioBtn1, // interviewRadioBtn1
                          radioSelectedValue:
                              selectedValueInterview, // selectedValueInterview
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          // isRequired: true,
                          showError: false,
                          onChange: (newValue) async {
                            final selectedItem = newValue as DropdownItemModel;
                            setState(() {
                              selectedValueInterview = selectedItem;
                            });
                          },
                        ),
                        if (selectedValueInterview?.name.toLowerCase() == "yes")
                          SizedBox(height: 10),

                        if (selectedValueInterview?.name.toLowerCase() == "yes")
                          TextAreaWidget(
                            height: 100,
                            maxLength: 1000,
                            isRequired: false,
                            // keyboardType: TextInputType.number,
                            hintText: "Maximum charcter limit is 1000",
                            controller:
                                interviewController, // interviewController
                            lable: "Interview Notes",
                            onChange: (value) {},
                          ),
                        SizedBox(height: 10),

                        // Issue Identified
                        SizedBox(height: 10),

                        const FieldLableWidget(
                          lable: "Issue Identified",
                          // isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonWidget(
                          radioItems:
                              issueIdentifiedRadioBtn, // issueIdentifiedRadioBtn
                          radioSelectedValue:
                              selectedValueIssueIdentified, // selectedValueIssueIdentified
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          // isRequired: true,
                          showError: false,
                          onChange: (newValue) async {
                            final selectedItem = newValue as DropdownItemModel;
                            setState(() {
                              selectedValueIssueIdentified = selectedItem;
                            });
                          },
                        ),
                        if (selectedValueIssueIdentified?.name.toLowerCase() ==
                            "yes")
                          SizedBox(height: 10),

                        if (selectedValueIssueIdentified?.name.toLowerCase() ==
                            "yes")
                          TextAreaWidget(
                            height: 75,
                            maxLength: 500,
                            isRequired: false,
                            // keyboardType: TextInputType.number,
                            hintText: "Maximum charcter limit is 500",
                            controller:
                                issueIdentifiedController, //issueIdentifiedController
                            lable: "Description",
                            onChange: (value) {},
                          ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question 1
                        // Question 1 - Property Review
                        const FieldLableWidget(
                          lable: "Is there a previous property assessment?",
                          isRequired: false,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonWidget(
                          radioItems: propertyReviewRadioBtn1,
                          radioSelectedValue: selectedValuePropertyReview1,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          isRequired: false,
                          showError: false,
                          onChange: (newValue) async {
                            final selectedItem = newValue as DropdownItemModel;
                            setState(() {
                              selectedValuePropertyReview1 = selectedItem;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget environmentalSiteEvaluationSection2() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Container(
            // color: Colors.white,
            // elevation: 4,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(8),
            // ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Description",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Divider(),

                        // Question 1
                        const FieldLableWidget(
                          lable:
                              "Are approvals required or anticipated for the work/site?",
                          isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonFormField(
                          radioItems: environmentalSiteRadioBtn1,
                          initialValue: selectedValueEnvironmentalSite1,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          isRequired: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueEnvironmentalSite1 = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 10),

                        // Question 2
                        const FieldLableWidget(
                          lable:
                              "Are there any sensitive receptors (i.e., school, daycare, assisted care, etc.) nearby that may be impacted by the current or future work?",
                          isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonFormField(
                          radioItems: environmentalSiteRadioBtn2,
                          initialValue: selectedValueEnvironmentalSite2,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          isRequired: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueEnvironmentalSite2 = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 10),

                        // Question 3
                        const FieldLableWidget(
                          lable:
                              "Is night work ongoing or will be required for further work ?",
                          isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonFormField(
                          radioItems: environmentalSiteRadioBtn3,
                          initialValue: selectedValueEnvironmentalSite3,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          isRequired: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueEnvironmentalSite3 = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 10),

                        // Question 4
                        const FieldLableWidget(
                          lable:
                              "Is there trucking and hauling or will it be required?",
                          isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonFormField(
                          radioItems: environmentalSiteRadioBtn4,
                          initialValue: selectedValueEnvironmentalSite4,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          isRequired: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueEnvironmentalSite4 = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 10),

                        // Question 5
                        const FieldLableWidget(
                          lable:
                              "Are there air impacts (e.g., dust, blasting, odour, vehicle emissions) from current or future work?",
                          isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonFormField(
                          radioItems: environmentalSiteRadioBtn5,
                          initialValue: selectedValueEnvironmentalSite5,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          isRequired: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueEnvironmentalSite5 = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 10),

                        // Question 6
                        const FieldLableWidget(
                          lable:
                              "Are there or will there be water withdrawals from the work?",
                          isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonFormField(
                          radioItems: environmentalSiteRadioBtn6,
                          initialValue: selectedValueEnvironmentalSite6,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          isRequired: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueEnvironmentalSite6 = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 10),

                        // Question 7
                        const FieldLableWidget(
                          lable:
                              "Does the current or future work require the removal of vegetation?",
                          isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonFormField(
                          radioItems: environmentalSiteRadioBtn7,
                          initialValue: selectedValueEnvironmentalSite7,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          isRequired: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueEnvironmentalSite7 = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 10),

                        // Question 8
                        const FieldLableWidget(
                          lable: "Are there wetlands on or near the site?",
                          isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonFormField(
                          radioItems: environmentalSiteRadioBtn8,
                          initialValue: selectedValueEnvironmentalSite8,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          isRequired: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueEnvironmentalSite8 = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 10),

                        // Question 9
                        const FieldLableWidget(
                          lable:
                              "Is there potable groundwater on or near the site?",
                          isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonFormField(
                          radioItems: environmentalSiteRadioBtn9,
                          initialValue: selectedValueEnvironmentalSite9,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          isRequired: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueEnvironmentalSite9 = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 10),

                        // Question 10
                        const FieldLableWidget(
                          lable:
                              "Are there or will be surface water bodies on or near the site (within 30 m)?",
                          isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonFormField(
                          radioItems: environmentalSiteRadioBtn10,
                          initialValue: selectedValueEnvironmentalSite10,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          isRequired: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueEnvironmentalSite10 = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 10),

                        // Question 11
                        const FieldLableWidget(
                          lable:
                              "Are there fish bearing water bodies on or near the site?",
                          isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonFormField(
                          radioItems: environmentalSiteRadioBtn11,
                          initialValue: selectedValueEnvironmentalSite11,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          isRequired: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueEnvironmentalSite11 = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 10),

                        // Question 12
                        const FieldLableWidget(
                          lable:
                              "Are any culverts and/or bridges are planned or being installed?",
                          isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonFormField(
                          radioItems: environmentalSiteRadioBtn12,
                          initialValue: selectedValueEnvironmentalSite12,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          isRequired: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueEnvironmentalSite12 = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 10),

                        // Question 13
                        const FieldLableWidget(
                          lable:
                              "Are there known archaeological and heritage resource?",
                          isRequired: true,
                          padding: EdgeInsets.only(left: 15),
                        ),
                        RadioButtonFormField(
                          radioItems: environmentalSiteRadioBtn13,
                          initialValue: selectedValueEnvironmentalSite13,
                          direction: RadioType.vertical,
                          activeColor: AppColors.appPrimaryColor,
                          isRequired: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueEnvironmentalSite13 = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget sampleCollectionSection2() {
    return Column();
  }

  Widget escInsepctionSection2() {
    return Column(
      children: [
        //Erosion and Sediment Control in ESC Inspection
        Padding(
          // padding: const EdgeInsets.all(0),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ExpanstionTileWidget(
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            // padding: const EdgeInsets.symmetric(horizontal: 15),
            isExpanded: false,
            expanstionTitle: 'Erosion and Sediment Control',
            suffixWidget: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    value: _erosionAndSedimentControlInESCInspectionIsChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _erosionAndSedimentControlInESCInspectionIsChecked =
                            value ?? false;
                        if (_erosionAndSedimentControlInESCInspectionIsChecked) {
                          selectedValueErosionAndSedimentControlInESCInspection1 =
                              erosionAndSedimentControlInESCInspectionRadioBtn1
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                          selectedValueErosionAndSedimentControlInESCInspection2 =
                              erosionAndSedimentControlInESCInspectionRadioBtn2
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );

                          selectedValueErosionAndSedimentControlInESCInspection3 =
                              erosionAndSedimentControlInESCInspectionRadioBtn3
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                          selectedValueErosionAndSedimentControlInESCInspection4 =
                              erosionAndSedimentControlInESCInspectionRadioBtn4
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                          selectedValueErosionAndSedimentControlInESCInspection5 =
                              erosionAndSedimentControlInESCInspectionRadioBtn5
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                          selectedValueErosionAndSedimentControlInESCInspection6 =
                              erosionAndSedimentControlInESCInspectionRadioBtn6
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                          selectedValueErosionAndSedimentControlInESCInspection7 =
                              erosionAndSedimentControlInESCInspectionRadioBtn7
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                          selectedValueErosionAndSedimentControlInESCInspection8 =
                              erosionAndSedimentControlInESCInspectionRadioBtn8
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                          selectedValueErosionAndSedimentControlInESCInspection9 =
                              erosionAndSedimentControlInESCInspectionRadioBtn9
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                        } else {
                          selectedValueErosionAndSedimentControlInESCInspection1 =
                              null;
                          selectedValueErosionAndSedimentControlInESCInspection2 =
                              null;
                          selectedValueErosionAndSedimentControlInESCInspection3 =
                              null;
                          selectedValueErosionAndSedimentControlInESCInspection4 =
                              null;
                          selectedValueErosionAndSedimentControlInESCInspection5 =
                              null;
                          selectedValueErosionAndSedimentControlInESCInspection6 =
                              null;
                          selectedValueErosionAndSedimentControlInESCInspection7 =
                              null;
                          selectedValueErosionAndSedimentControlInESCInspection8 =
                              null;
                          selectedValueErosionAndSedimentControlInESCInspection9 =
                              null;
                        }
                      });
                    },
                  ),
                  const Text(
                    "Not Applicable",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),

            widgetList: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(),

                    //  Question 1
                    const FieldLableWidget(
                      lable:
                          "Silt Fence (standing upright, no gaps, silt accumulation removed).",
                      //isRequired: false
                      // padding: EdgeInsets.only(left: 15),
                    ),

                    RadioButtonWidget(
                      radioItems:
                          erosionAndSedimentControlInESCInspectionRadioBtn1,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControlInESCInspection1,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection
                        setState(() {
                          selectedValueErosionAndSedimentControlInESCInspection1 =
                              selectedItem;
                        });

                        // If selected is "No", open CaDescriptionScreen with a unique ID
                        print("${selectedItem.name.toLowerCase()} ======hi");
                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              print("result added ${result}");
                              submittedCorrectiveActions.add(result);
                              // print(submittedCorrectiveActions);

                              // Optionally store the result tied to this radio question
                              // e.g., map it by question key, or just print/log
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : ${e}");
                            }
                          } else {
                            print("not called ");
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                    ),
                    TextAreaWidget(
                      // //padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller:
                          erosionAndSedimentControlInESCInspectionController1,
                      lable: "Comment",
                      onChange: (value) {},
                    ),

                    SizedBox(height: 15),
                    // Q1
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: erosionSedimentQ1Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ1Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: erosionSedimentQ1Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ1Photos = files);
                    //   },
                    // ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: screen1Q1DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: screen1Q1PhotosKey,
                    ),

                    SizedBox(height: 15),

                    // Question 2
                    const FieldLableWidget(
                      lable:
                          "Check Dams (in good condition, silt accumulation removed, no evidence of water circumventing the check dam)",
                      // padding: EdgeInsets.only(left: 15),
                    ),

                    RadioButtonWidget(
                      radioItems:
                          erosionAndSedimentControlInESCInspectionRadioBtn2,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControlInESCInspection2,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueErosionAndSedimentControlInESCInspection2 =
                              selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),
                    TextAreaWidget(
                      // //padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller:
                          erosionAndSedimentControlInESCInspectionController2,
                      lable: "Comment",
                      onChange: (value) {},
                    ),

                    SizedBox(height: 15),

                    // Q2
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: erosionSedimentQ2Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ2Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: erosionSedimentQ2Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ2Photos = files);
                    //   },
                    // ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: screen1Q2DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: screen1Q2PhotosKey,
                    ),
                    SizedBox(height: 15),

                    // Question 3
                    const FieldLableWidget(
                      lable:
                          "Sediment Ponds/Sumps (sufficient size, no leaking, clear water being discharged)",
                      // padding: EdgeInsets.only(left: 15),
                    ),

                    RadioButtonWidget(
                      radioItems:
                          erosionAndSedimentControlInESCInspectionRadioBtn3,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControlInESCInspection3,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueErosionAndSedimentControlInESCInspection3 =
                              selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),
                    TextAreaWidget(
                      // //padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller:
                          erosionAndSedimentControlInESCInspectionController3,
                      lable: "Comment",
                      onChange: (value) {},
                    ),

                    SizedBox(height: 15),
                    // Q3
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: erosionSedimentQ3Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ3Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: erosionSedimentQ3Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ3Photos = files);
                    //   },
                    // ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: screen1Q3DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: screen1Q3PhotosKey,
                    ),
                    SizedBox(height: 15),

                    // Question 4
                    const FieldLableWidget(
                      lable:
                          "Exposed Surfaces (covered in straw, mulch, stone, or other covering material)",
                      // padding: EdgeInsets.only(left: 15),
                    ),

                    RadioButtonWidget(
                      radioItems:
                          erosionAndSedimentControlInESCInspectionRadioBtn4,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControlInESCInspection4,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueErosionAndSedimentControlInESCInspection4 =
                              selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),
                    TextAreaWidget(
                      // //padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller:
                          erosionAndSedimentControlInESCInspectionController4,
                      lable: "Comment",
                      onChange: (value) {},
                    ),

                    SizedBox(height: 15),
                    // Q4
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: erosionSedimentQ4Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ4Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: erosionSedimentQ4Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ4Photos = files);
                    //   },
                    // ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: screen1Q4DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: screen1Q4PhotosKey,
                    ),
                    SizedBox(height: 15),

                    // Question 5
                    const FieldLableWidget(
                      lable:
                          "Sloping (finished slopes adequately stabilized, no evidence of erosion on previously stabilized area)",
                      // padding: EdgeInsets.only(left: 15),
                    ),

                    RadioButtonWidget(
                      radioItems:
                          erosionAndSedimentControlInESCInspectionRadioBtn5,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControlInESCInspection5,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueErosionAndSedimentControlInESCInspection5 =
                              selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),
                    TextAreaWidget(
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller:
                          erosionAndSedimentControlInESCInspectionController5,
                      lable: "Comment",
                      onChange: (value) {},
                    ),

                    SizedBox(height: 15),

                    // Q5
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: erosionSedimentQ5Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ5Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: erosionSedimentQ5Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ5Photos = files);
                    //   },
                    // ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: screen1Q5DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: screen1Q5PhotosKey,
                    ),
                    SizedBox(height: 15),

                    // Question 6
                    const FieldLableWidget(
                      lable:
                          "Stockpiles (suitably sloped, appropriately managed)",
                      // padding: EdgeInsets.only(left: 15),
                    ),

                    RadioButtonWidget(
                      radioItems:
                          erosionAndSedimentControlInESCInspectionRadioBtn6,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControlInESCInspection6,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueErosionAndSedimentControlInESCInspection6 =
                              selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),
                    TextAreaWidget(
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller:
                          erosionAndSedimentControlInESCInspectionController6,
                      lable: "Comment",
                      onChange: (value) {},
                    ),

                    SizedBox(height: 15),
                    // Q6
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: erosionSedimentQ6Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ6Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: erosionSedimentQ6Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ6Photos = files);
                    //   },
                    // ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: screen1Q6DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: screen1Q6PhotosKey,
                    ),
                    SizedBox(height: 15),

                    // Question 7
                    const FieldLableWidget(
                      lable: "Temporary Road (stable, in good condition)",
                      // padding: EdgeInsets.only(left: 15),
                    ),

                    RadioButtonWidget(
                      radioItems:
                          erosionAndSedimentControlInESCInspectionRadioBtn7,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControlInESCInspection7,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueErosionAndSedimentControlInESCInspection7 =
                              selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),
                    TextAreaWidget(
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller:
                          erosionAndSedimentControlInESCInspectionController7,
                      lable: "Comment",
                      onChange: (value) {},
                    ),
                    SizedBox(height: 15),

                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: screen1Q7DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: screen1Q7PhotosKey,
                    ),

                    SizedBox(height: 15),

                    // Question 8
                    const FieldLableWidget(
                      lable: "Site Access (no mud being tracked offsite)",
                      // padding: EdgeInsets.only(left: 15),
                    ),

                    RadioButtonWidget(
                      radioItems:
                          erosionAndSedimentControlInESCInspectionRadioBtn8,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControlInESCInspection8,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueErosionAndSedimentControlInESCInspection8 =
                              selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),
                    TextAreaWidget(
                      // //padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller:
                          erosionAndSedimentControlInESCInspectionController8,
                      lable: "Comment",
                      onChange: (value) {},
                    ),
                    SizedBox(height: 15),

                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: screen1Q8DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: screen1Q8PhotosKey,
                    ),

                    SizedBox(height: 15),
                    // Q8
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: erosionSedimentQ8Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ8Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: erosionSedimentQ8Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ8Photos = files);
                    //   },
                    // ),
                    SizedBox(height: 15),

                    // Question 9
                    const FieldLableWidget(
                      lable:
                          "Vegetation (existing vegetation is being managed and maintained)",
                      // padding: EdgeInsets.only(left: 15),
                    ),

                    RadioButtonWidget(
                      radioItems:
                          erosionAndSedimentControlInESCInspectionRadioBtn9,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControlInESCInspection9,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueErosionAndSedimentControlInESCInspection9 =
                              selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),
                    TextAreaWidget(
                      // ////padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller:
                          erosionAndSedimentControlInESCInspectionController9,
                      lable: "Comment",
                      onChange: (value) {},
                    ),

                    SizedBox(height: 15),
                    // Q9
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: erosionSedimentQ9Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ9Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: erosionSedimentQ9Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => erosionSedimentQ9Photos = files);
                    //   },
                    // ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: screen1Q9DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: screen1Q9PhotosKey,
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
              // Container(height: 1000, width: 50, color: Colors.red),
            ],
          ),
        ),

        // Water Management in Esc Inspection
        Padding(
          // padding: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: ExpanstionTileWidget(
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            // padding: const EdgeInsets.only(top: 15),
            isExpanded: false,
            expanstionTitle: 'Water Management',
            suffixWidget: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    value: _waterManagementInESCInspectionIsChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _waterManagementInESCInspectionIsChecked =
                            value ?? false;
                        if (_waterManagementInESCInspectionIsChecked) {
                          selectedValueWaterManagementInESCInspection1 =
                              waterManagementInESCInspectionRadioBtn1
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                          selectedValueWaterManagementInESCInspection2 =
                              waterManagementInESCInspectionRadioBtn2
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );

                          selectedValueWaterManagementInESCInspection3 =
                              waterManagementInESCInspectionRadioBtn3
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                          selectedValueWaterManagementInESCInspection4 =
                              waterManagementInESCInspectionRadioBtn4
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                          selectedValueWaterManagementInESCInspection5 =
                              waterManagementInESCInspectionRadioBtn5
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                          selectedValueWaterManagementInESCInspection6 =
                              waterManagementInESCInspectionRadioBtn6
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                          selectedValueWaterManagementInESCInspection7 =
                              waterManagementInESCInspectionRadioBtn7
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                          selectedValueWaterManagementInESCInspection8 =
                              waterManagementInESCInspectionRadioBtn8
                                  .firstWhere(
                                    (item) => item.name == "Not Applicable",
                                  );
                        } else {
                          selectedValueWaterManagementInESCInspection1 = null;
                          selectedValueWaterManagementInESCInspection2 = null;
                          selectedValueWaterManagementInESCInspection3 = null;
                          selectedValueWaterManagementInESCInspection4 = null;
                          selectedValueWaterManagementInESCInspection5 = null;
                          selectedValueWaterManagementInESCInspection6 = null;
                          selectedValueWaterManagementInESCInspection7 = null;
                          selectedValueWaterManagementInESCInspection8 = null;
                        }
                      });
                    },
                  ),
                  const Text(
                    "Not Applicable",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),

            widgetList: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(),
                    // Question 1
                    const FieldLableWidget(
                      lable: "Water Quality (clear and silt free)",
                      // padding: EdgeInsets.only(left: 15),
                    ),

                    RadioButtonWidget(
                      radioItems: waterManagementInESCInspectionRadioBtn1,
                      radioSelectedValue:
                          selectedValueWaterManagementInESCInspection1,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueWaterManagementInESCInspection1 =
                              selectedItem;
                        });

                        print("${selectedItem.name.toLowerCase()} ======hi");
                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              print("result added $result");
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),

                    TextAreaWidget(
                      ////padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller: waterManagementInESCInspectionController1,
                      lable: "Comment",
                      onChange: (value) {},
                    ),

                    SizedBox(height: 15),

                    // After TextAreaWidget for Q1
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: waterManagementQ1Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ1Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: waterManagementQ1Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ1Photos = files);
                    //   },
                    // ),
                    // Question 1
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: waterManagementQ1DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: waterManagementQ1PhotosKey,
                    ),
                    SizedBox(height: 15),

                    // Question 2
                    const FieldLableWidget(
                      lable:
                          "Sediment Laden Water Pumping (sufficient pump size(s), in good working order, no leaks in hoses, discharge to vegetation or silt bag >30 m from watercourse)",
                      // //padding: EdgeInsets.symmetric(horizontal: 15),
                    ),

                    RadioButtonWidget(
                      radioItems: waterManagementInESCInspectionRadioBtn2,
                      radioSelectedValue:
                          selectedValueWaterManagementInESCInspection2,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueWaterManagementInESCInspection2 =
                              selectedItem;
                        });

                        print("${selectedItem.name.toLowerCase()} ======hi");
                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              print("result added $result");
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),

                    TextAreaWidget(
                      ////padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller: waterManagementInESCInspectionController2,
                      lable: "Comment",
                      onChange: (value) {},
                    ),

                    SizedBox(height: 15),
                    // After TextAreaWidget for Q2
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: waterManagementQ2Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ2Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: waterManagementQ2Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ2Photos = files);
                    //   },
                    // ),

                    // Question 2
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: waterManagementQ2DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: waterManagementQ2PhotosKey,
                    ),
                    SizedBox(height: 15),

                    // Question 3
                    const FieldLableWidget(
                      lable:
                          "Stormwater Infrastructure (silt-laden water is prevented from entering catch basins and ditches)",
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                    ),

                    RadioButtonWidget(
                      radioItems: waterManagementInESCInspectionRadioBtn3,
                      radioSelectedValue:
                          selectedValueWaterManagementInESCInspection3,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueWaterManagementInESCInspection3 =
                              selectedItem;
                        });

                        print("${selectedItem.name.toLowerCase()} ======hi");
                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              print("result added $result");
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),

                    TextAreaWidget(
                      ////padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller: waterManagementInESCInspectionController3,
                      lable: "Comment",
                      onChange: (value) {},
                    ),

                    SizedBox(height: 15),
                    // After TextAreaWidget for Q3
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: waterManagementQ3Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ3Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: waterManagementQ3Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ3Photos = files);
                    //   },
                    // ),

                    // Question 3
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: waterManagementQ3DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: waterManagementQ3PhotosKey,
                    ),
                    SizedBox(height: 15),

                    // Question 4
                    const FieldLableWidget(
                      lable:
                          "Temporary Culverts (stable, no mud or sediment tracking into watercourse)",
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                    ),

                    RadioButtonWidget(
                      radioItems: waterManagementInESCInspectionRadioBtn4,
                      radioSelectedValue:
                          selectedValueWaterManagementInESCInspection4,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueWaterManagementInESCInspection4 =
                              selectedItem;
                        });

                        print("${selectedItem.name.toLowerCase()} ======hi");
                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              print("result added $result");
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),

                    TextAreaWidget(
                      ////padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller: waterManagementInESCInspectionController4,
                      lable: "Comment",
                      onChange: (value) {},
                    ),

                    SizedBox(height: 15),
                    // After TextAreaWidget for Q4
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: waterManagementQ4Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ4Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: waterManagementQ4Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ4Photos = files);
                    //   },
                    // ),

                    // Question 4
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: waterManagementQ4DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: waterManagementQ4PhotosKey,
                    ),
                    SizedBox(height: 15),

                    // Question 5
                    const FieldLableWidget(
                      lable:
                          "Temporary Bridges (no part of structure below high water mark, bridge surface is clean)",
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                    ),

                    RadioButtonWidget(
                      radioItems: waterManagementInESCInspectionRadioBtn5,
                      radioSelectedValue:
                          selectedValueWaterManagementInESCInspection5,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueWaterManagementInESCInspection5 =
                              selectedItem;
                        });

                        print("${selectedItem.name.toLowerCase()} ======hi");
                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              print("result added $result");
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),

                    TextAreaWidget(
                      ////padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller: waterManagementInESCInspectionController5,
                      lable: "Comment",
                      onChange: (value) {},
                    ),

                    SizedBox(height: 15),

                    // After TextAreaWidget for Q5
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: waterManagementQ5Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ5Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: waterManagementQ5Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ5Photos = files);
                    //   },
                    // ),
                    // Question 5
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: waterManagementQ5DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: waterManagementQ5PhotosKey,
                    ),
                    SizedBox(height: 15),

                    // Question 6
                    const FieldLableWidget(
                      lable:
                          "Cofferdams (in good condition, constructed with an impermeable barrier, no evidence of water circumventing the cofferdam).",
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                    ),

                    RadioButtonWidget(
                      radioItems: waterManagementInESCInspectionRadioBtn6,
                      radioSelectedValue:
                          selectedValueWaterManagementInESCInspection6,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueWaterManagementInESCInspection6 =
                              selectedItem;
                        });

                        print("${selectedItem.name.toLowerCase()} ======hi");
                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              print("result added $result");
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),

                    TextAreaWidget(
                      ////padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller: waterManagementInESCInspectionController6,
                      lable: "Comment",
                      onChange: (value) {},
                    ),

                    SizedBox(height: 15),

                    // After TextAreaWidget for Q6
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: waterManagementQ6Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ6Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: waterManagementQ6Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ6Photos = files);
                    //   },
                    // ),

                    // Question 6
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: waterManagementQ6DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: waterManagementQ6PhotosKey,
                    ),

                    SizedBox(height: 15),

                    // Question 7
                    const FieldLableWidget(
                      lable:
                          "Silt Booms/Curtains (free of rips, firmly anchored to the bottom)",
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                    ),

                    RadioButtonWidget(
                      radioItems: waterManagementInESCInspectionRadioBtn7,
                      radioSelectedValue:
                          selectedValueWaterManagementInESCInspection7,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueWaterManagementInESCInspection7 =
                              selectedItem;
                        });

                        print("${selectedItem.name.toLowerCase()} ======hi");
                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              print("result added $result");
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),

                    TextAreaWidget(
                      ////padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Charcter limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller: waterManagementInESCInspectionController7,
                      lable: "Comment",
                      onChange: (value) {},
                    ),

                    SizedBox(height: 15),
                    // After TextAreaWidget for Q7
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: waterManagementQ7Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ7Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: waterManagementQ7Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ7Photos = files);
                    //   },
                    // ),

                    // Question 7
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: waterManagementQ7DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: waterManagementQ7PhotosKey,
                    ),
                    // Question 8
                    const FieldLableWidget(
                      lable:
                          "Is fuel and hydrocarbon storage and/or refueling being completed 30m away from a watercourse or wetlands?",
                      // padding: EdgeInsets.only(left: 15),
                    ),

                    RadioButtonWidget(
                      radioItems: waterManagementInESCInspectionRadioBtn8,
                      radioSelectedValue:
                          selectedValueWaterManagementInESCInspection8,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueWaterManagementInESCInspection8 =
                              selectedItem;
                        });

                        print("${selectedItem.name.toLowerCase()} ======hi");
                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              print("result added $result");
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),

                    SizedBox(height: 15),
                    // After TextAreaWidget for Q8
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: waterManagementQ8Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ8Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: waterManagementQ8Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => waterManagementQ8Photos = files);
                    //   },
                    // ),

                    // Question 8
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: waterManagementQ8DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: waterManagementQ8PhotosKey,
                    ),

                    // sizedBox(height: 15),
                  ],
                ),
              ),
              // Container(height: 1000, width: 50, color: Colors.red),
            ],
          ),
        ),

        // Site Conditions & Housekeeping
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: ExpanstionTileWidget(
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            isExpanded: false,
            expanstionTitle: 'Site Conditions & Housekeeping',
            suffixWidget: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    value: _siteConditionsHousekeepingIsChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _siteConditionsHousekeepingIsChecked = value ?? false;

                        if (_siteConditionsHousekeepingIsChecked) {
                          selectedValueSiteConditionsHousekeeping1 =
                              siteConditionsHousekeepingRadioBtn1.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueSiteConditionsHousekeeping2 =
                              siteConditionsHousekeepingRadioBtn2.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueSiteConditionsHousekeeping3 =
                              siteConditionsHousekeepingRadioBtn3.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                        } else {
                          selectedValueSiteConditionsHousekeeping1 = null;
                          selectedValueSiteConditionsHousekeeping2 = null;
                          selectedValueSiteConditionsHousekeeping3 = null;
                        }
                      });
                    },
                  ),
                  const Text(
                    "Not Applicable",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),
            widgetList: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(),

                    // Question 1
                    const FieldLableWidget(
                      lable:
                          "Housekeeping (site is free of trash, good housekeeping practices in place)",
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: siteConditionsHousekeepingRadioBtn1,
                      radioSelectedValue:
                          selectedValueSiteConditionsHousekeeping1,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueSiteConditionsHousekeeping1 =
                              selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),
                    TextAreaWidget(
                      ////padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Character limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller: siteConditionsHousekeepingController1,
                      lable: "Comment",
                      onChange: (value) {},
                    ),
                    SizedBox(height: 15),
                    // After TextAreaWidget for Q1
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: housekeepingQ1Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => housekeepingQ1Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: housekeepingQ1Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => housekeepingQ1Photos = files);
                    //   },
                    // ),
                    // Question 1
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: siteConditionsQ1DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: siteConditionsQ1PhotosKey,
                    ),

                    SizedBox(height: 15),

                    // Question 2
                    const FieldLableWidget(
                      lable: "Dust (preventative measures in place)",
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: siteConditionsHousekeepingRadioBtn2,
                      radioSelectedValue:
                          selectedValueSiteConditionsHousekeeping2,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueSiteConditionsHousekeeping2 =
                              selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),
                    TextAreaWidget(
                      ////padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Character limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller: siteConditionsHousekeepingController2,
                      lable: "Comment",
                      onChange: (value) {},
                    ),
                    SizedBox(height: 15),
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: housekeepingQ2Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => housekeepingQ2Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: housekeepingQ2Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => housekeepingQ2Photos = files);
                    //   },
                    // ),

                    // Question 2
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: siteConditionsQ2DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: siteConditionsQ2PhotosKey,
                    ),
                    SizedBox(height: 15),

                    // Question 3
                    const FieldLableWidget(
                      lable:
                          "Is waste secured to reduce wildlife interactions?",
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: siteConditionsHousekeepingRadioBtn3,
                      radioSelectedValue:
                          selectedValueSiteConditionsHousekeeping3,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        setState(() {
                          selectedValueSiteConditionsHousekeeping3 =
                              selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() ==
                            'needs improvement') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              submittedCorrectiveActions.add(result);
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : $e");
                            }
                          } else {
                            print("not called ");
                          }
                        }
                      },
                    ),
                    TextAreaWidget(
                      ////padding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Maximum Character limit is 500",
                      maxLength: 500,
                      height: 70,
                      controller: siteConditionsHousekeepingController3,
                      lable: "Comment",
                      onChange: (value) {},
                    ),
                    SizedBox(height: 15),
                    // AttachmentSection(
                    //   title: "Attach Documents",
                    //   isDocument: true,
                    //   files: housekeepingQ3Docs,
                    //   onFilesChanged: (files) {
                    //     setState(() => housekeepingQ3Docs = files);
                    //   },
                    // ),
                    // AttachmentSection(
                    //   title: "Attach Photos",
                    //   isDocument: false,
                    //   files: housekeepingQ3Photos,
                    //   onFilesChanged: (files) {
                    //     setState(() => housekeepingQ3Photos = files);
                    //   },
                    // ),

                    // Question 3
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Documents",
                      isDocument: true,
                      storageKey: siteConditionsQ3DocumentsKey,
                    ),
                    DocumentAndPhotoUploadWidget(
                      title: "Attach Photos",
                      isDocument: false,
                      storageKey: siteConditionsQ3PhotosKey,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget envInspectionsection2() {
    return Column(
      children: [
        //Administrative controls
        Padding(
          // padding: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: ExpanstionTileWidget(
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            // padding: const EdgeInsets.only(top: 15),
            isExpanded: false,
            expanstionTitle: 'Administrative Controls',
            suffixWidget: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    activeColor: AppColors.appPrimaryColor,
                    value: _administratorControlsIsChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _administratorControlsIsChecked = value ?? false;
                        if (_administratorControlsIsChecked) {
                          selectedValueAdministratorControls1 =
                              administrativeControlsRadioBtn1.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueAdministratorControls2 =
                              administrativeControlsRadioBtn2.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );

                          selectedValueAdministratorControls3 =
                              administrativeControlsRadioBtn3.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueAdministratorControls4 =
                              administrativeControlsRadioBtn4.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                        } else {
                          selectedValueAdministratorControls1 = null;
                          selectedValueAdministratorControls2 = null;
                          selectedValueAdministratorControls3 = null;
                          selectedValueAdministratorControls4 = null;
                        }
                      });
                    },
                  ),
                  const Text(
                    "Not Applicable",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),

            widgetList: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(),

                    // Q1
                    const FieldLableWidget(
                      lable:
                          "Are site specific environmental approvals readily available on site and/or digitally ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),

                    RadioButtonWidget(
                      radioItems: administrativeControlsRadioBtn1,
                      radioSelectedValue: selectedValueAdministratorControls1,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection
                        setState(() {
                          selectedValueAdministratorControls1 = selectedItem;
                          print(
                            "${selectedValueAdministratorControls1?.name} 1234567890",
                          );
                        });

                        // If selected is "No", open CaDescriptionScreen with a unique ID
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              print("result added ${result}");
                              submittedCorrectiveActions.add(result);
                              // print(submittedCorrectiveActions);

                              // Optionally store the result tied to this radio question
                              // e.g., map it by question key, or just print/log
                              print('Corrective action submitted: $result');
                            } catch (e) {
                              print("print e : ${e}");
                            }
                          } else {
                            print("not called ");
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                    ),

                    SizedBox(height: 15),

                    // Q2
                    const FieldLableWidget(
                      lable: "Is the site-specific ESC plan being followed ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: administrativeControlsRadioBtn2,
                      radioSelectedValue: selectedValueAdministratorControls2,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueAdministratorControls2 = selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            try {
                              print("result added2 ${result}");
                              submittedCorrectiveActions.add(result);
                              print(submittedCorrectiveActions);

                              // Optionally store the result tied to this radio question
                              // e.g., map it by question key, or just print/log
                              print('Corrective action submitted2: $result');
                            } catch (e) {
                              print("print e2 : ${e}");
                            }
                          } else {
                            print("not called2 ");
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q3
                    const FieldLableWidget(
                      lable:
                          "Has the integrity of the ESC mesaures been maintained ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: administrativeControlsRadioBtn3,
                      radioSelectedValue: selectedValueAdministratorControls3,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueAdministratorControls3 = selectedItem;
                        });
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q4
                    const FieldLableWidget(
                      lable:
                          "Does the site Supervisor have access to the relevent environmental documentation ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: administrativeControlsRadioBtn4,
                      radioSelectedValue: selectedValueAdministratorControls4,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueAdministratorControls4 = selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              // Container(height: 1000, width: 50, color: Colors.red),
            ],
          ),
        ),

        // Erosion and sediment control
        Padding(
          // padding: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),

          child: ExpanstionTileWidget(
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            // padding: const EdgeInsets.only(top: 15),
            isExpanded: false,
            expanstionTitle: 'Erosion And Sediment Control',
            suffixWidget: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    activeColor: AppColors.appPrimaryColor,
                    value: _erosionAndSedimentControlIsChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _erosionAndSedimentControlIsChecked = value ?? false;
                        if (_erosionAndSedimentControlIsChecked) {
                          selectedValueErosionAndSedimentControl1 =
                              erosionAndSedimentControlRadioBtn1.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueErosionAndSedimentControl2 =
                              erosionAndSedimentControlRadioBtn2.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueErosionAndSedimentControl3 =
                              erosionAndSedimentControlRadioBtn3.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueErosionAndSedimentControl4 =
                              erosionAndSedimentControlRadioBtn4.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueErosionAndSedimentControl5 =
                              erosionAndSedimentControlRadioBtn5.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueErosionAndSedimentControl6 =
                              erosionAndSedimentControlRadioBtn6.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueErosionAndSedimentControl7 =
                              erosionAndSedimentControlRadioBtn7.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueErosionAndSedimentControl8 =
                              erosionAndSedimentControlRadioBtn8.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                        } else {
                          selectedValueErosionAndSedimentControl1 = null;
                          selectedValueErosionAndSedimentControl2 = null;
                          selectedValueErosionAndSedimentControl3 = null;
                          selectedValueErosionAndSedimentControl4 = null;
                          selectedValueErosionAndSedimentControl5 = null;
                          selectedValueErosionAndSedimentControl6 = null;
                          selectedValueErosionAndSedimentControl7 = null;
                          selectedValueErosionAndSedimentControl8 = null;
                        }
                      });
                    },
                  ),
                  const Text(
                    "Not Applicable",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),

            widgetList: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(),

                    // Q1
                    const FieldLableWidget(
                      lable: "Have appropriate ESC strategies been applied ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: erosionAndSedimentControlRadioBtn1,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControl1,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueErosionAndSedimentControl1 =
                              selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q2
                    const FieldLableWidget(
                      lable: "Is the site-specific ESC plan being followed ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: erosionAndSedimentControlRadioBtn2,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControl2,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueErosionAndSedimentControl2 =
                              selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q3
                    const FieldLableWidget(
                      lable:
                          "Has the integrity of ESC measures been maintained ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: erosionAndSedimentControlRadioBtn3,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControl3,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueErosionAndSedimentControl3 =
                              selectedItem;
                        });
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q4
                    const FieldLableWidget(
                      lable:
                          "Is site drainage directed away from sensitive receptors ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: erosionAndSedimentControlRadioBtn4,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControl4,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueErosionAndSedimentControl4 =
                              selectedItem;
                        });

                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q5
                    const FieldLableWidget(
                      lable:
                          "Is sediment laden water being pumped to vegetation or holding pond ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: erosionAndSedimentControlRadioBtn5,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControl5,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueErosionAndSedimentControl5 =
                              selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q6
                    const FieldLableWidget(
                      lable: "Do site discharges appear to be clear ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: erosionAndSedimentControlRadioBtn6,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControl6,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueErosionAndSedimentControl6 =
                              selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q7
                    const FieldLableWidget(
                      lable:
                          "Are temporary diversions being managed appropriately ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: erosionAndSedimentControlRadioBtn7,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControl7,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueErosionAndSedimentControl7 =
                              selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q8
                    const FieldLableWidget(
                      lable:
                          "Are temporary crossings installed and managed correctly ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: erosionAndSedimentControlRadioBtn8,
                      radioSelectedValue:
                          selectedValueErosionAndSedimentControl8,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueErosionAndSedimentControl8 =
                              selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              // Container(height: 1000, width: 50, color: Colors.red),
            ],
          ),
        ),

        // Fuel and oil Management
        Padding(
          // padding: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),

          child: ExpanstionTileWidget(
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            // padding: const EdgeInsets.only(top: 15),
            isExpanded: false,
            expanstionTitle: 'Fuel and oil Management',
            suffixWidget: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    activeColor: AppColors.appPrimaryColor,
                    value: _fuelAndOilManagementIsChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _fuelAndOilManagementIsChecked = value ?? false;
                        if (_fuelAndOilManagementIsChecked) {
                          selectedValueFuelAndOilManagement1 =
                              fuelAndOilManagementRadioBtn1.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueFuelAndOilManagement2 =
                              fuelAndOilManagementRadioBtn2.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueFuelAndOilManagement3 =
                              fuelAndOilManagementRadioBtn3.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueFuelAndOilManagement4 =
                              fuelAndOilManagementRadioBtn4.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                        } else {
                          selectedValueFuelAndOilManagement1 = null;
                          selectedValueFuelAndOilManagement2 = null;
                          selectedValueFuelAndOilManagement3 = null;
                          selectedValueFuelAndOilManagement4 = null;
                        }
                      });
                    },
                  ),
                  const Text(
                    "Not Applicable",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),

            widgetList: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(),

                    // Q1
                    const FieldLableWidget(
                      lable:
                          "Is the site free from evidence of spills/releases ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: fuelAndOilManagementRadioBtn1,
                      radioSelectedValue: selectedValueFuelAndOilManagement1,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,
                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueFuelAndOilManagement1 = selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q2
                    const FieldLableWidget(
                      lable:
                          "Is there petroleum or hazardous material storage onn site ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: fuelAndOilManagementRadioBtn2,
                      radioSelectedValue: selectedValueFuelAndOilManagement2,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueFuelAndOilManagement2 = selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q3
                    const FieldLableWidget(
                      lable:
                          "Are refueling areas and storage of fuel set back from evironmentally sensitive areas (at least 30 m) ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: fuelAndOilManagementRadioBtn3,
                      radioSelectedValue: selectedValueFuelAndOilManagement3,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueFuelAndOilManagement3 = selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q4
                    const FieldLableWidget(
                      lable:
                          "Does thae site or equipment have appropriate spill response materials ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: fuelAndOilManagementRadioBtn4,
                      radioSelectedValue: selectedValueFuelAndOilManagement4,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueFuelAndOilManagement4 = selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              // Container(height: 1000, width: 50, color: Colors.red),
            ],
          ),
        ),

        // Waste Management
        Padding(
          // padding: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),

          child: ExpanstionTileWidget(
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            // padding: const EdgeInsets.only(top: 15),
            isExpanded: false,
            expanstionTitle: 'Waste Management',
            suffixWidget: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    activeColor: AppColors.appPrimaryColor,
                    value: _wasteManagementIsChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _wasteManagementIsChecked = value ?? false;
                        if (_wasteManagementIsChecked) {
                          selectedValueWasteManagement1 =
                              wasteManagementRadioBtn1.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueWasteManagement2 =
                              wasteManagementRadioBtn2.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueWasteManagement3 =
                              wasteManagementRadioBtn3.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                        } else {
                          selectedValueWasteManagement1 = null;
                          selectedValueWasteManagement2 = null;
                          selectedValueWasteManagement3 = null;
                        }
                      });
                    },
                  ),
                  const Text(
                    "Not Applicable",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),

            widgetList: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(),

                    // Q1
                    const FieldLableWidget(
                      lable:
                          "Is waste being sorted and handled properly (including hazardous waste) ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: wasteManagementRadioBtn1,
                      radioSelectedValue: selectedValueWasteManagement1,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueWasteManagement1 = selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q2
                    const FieldLableWidget(
                      lable: "Is site free from litter ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: wasteManagementRadioBtn2,
                      radioSelectedValue: selectedValueWasteManagement2,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueWasteManagement2 = selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q3
                    const FieldLableWidget(
                      lable: "Is there evidence of illegal dumping ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: wasteManagementRadioBtn3,
                      radioSelectedValue: selectedValueWasteManagement3,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueWasteManagement3 = selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              // Container(height: 1000, width: 50, color: Colors.red),
            ],
          ),
        ),

        // wildlife
        Padding(
          // padding: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),

          child: ExpanstionTileWidget(
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            // padding: const EdgeInsets.only(top: 15),
            isExpanded: false,
            expanstionTitle: 'Wildlife',
            suffixWidget: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    activeColor: AppColors.appPrimaryColor,
                    value: _wildlifeIsChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _wildlifeIsChecked = value ?? false;
                        if (_wildlifeIsChecked) {
                          selectedValueWildlife1 = wildlifeRadioBtn1.firstWhere(
                            (item) => item.name == "Not Applicable",
                          );
                          selectedValueWildlife2 = wildlifeRadioBtn2.firstWhere(
                            (item) => item.name == "Not Applicable",
                          );
                          selectedValueWildlife3 = wildlifeRadioBtn3.firstWhere(
                            (item) => item.name == "Not Applicable",
                          );
                        } else {
                          selectedValueWildlife1 = null;
                          selectedValueWildlife2 = null;
                          selectedValueWildlife3 = null;
                        }
                      });
                    },
                  ),
                  const Text(
                    "Not Applicable",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),

            widgetList: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(),

                    // Q1
                    const FieldLableWidget(
                      lable:
                          "Is the site being maintained to reduce interaction with wildlife ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: wildlifeRadioBtn1,
                      radioSelectedValue: selectedValueWildlife1,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueWildlife1 = selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q2
                    const FieldLableWidget(
                      lable:
                          "Is there evidence of nesting or migratory birds (April 15 - August 31) ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: wildlifeRadioBtn2,
                      radioSelectedValue: selectedValueWildlife2,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueWildlife2 = selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q3
                    const FieldLableWidget(
                      lable: "Is this a potential site of SAR species ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: wildlifeRadioBtn3,
                      radioSelectedValue: selectedValueWildlife3,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueWildlife3 = selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            print('notr submiteed 3');
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              // Container(height: 1000, width: 50, color: Colors.red),
            ],
          ),
        ),

        // Air Quality Management
        Padding(
          // padding: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),

          child: ExpanstionTileWidget(
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            // padding: const EdgeInsets.only(top: 15),
            isExpanded: false,
            expanstionTitle: 'Air Quality Management',
            suffixWidget: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    activeColor: AppColors.appPrimaryColor,
                    value: _airQualityManagementIsChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _airQualityManagementIsChecked = value ?? false;
                        if (_airQualityManagementIsChecked) {
                          selectedValueairQualityManagement1 =
                              airQualityManagementRadioBtn1.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueairQualityManagement2 =
                              airQualityManagementRadioBtn2.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                          selectedValueairQualityManagement3 =
                              airQualityManagementRadioBtn3.firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                        } else {
                          selectedValueairQualityManagement1 = null;
                          selectedValueairQualityManagement2 = null;
                          selectedValueairQualityManagement3 = null;
                        }
                      });
                    },
                  ),
                  const Text(
                    "Not Applicable",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),

            widgetList: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(),

                    // Q1
                    const FieldLableWidget(
                      lable: "Is dust being controlled ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: airQualityManagementRadioBtn1,
                      radioSelectedValue: selectedValueairQualityManagement1,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueairQualityManagement1 = selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q2
                    const FieldLableWidget(
                      lable: "Is vehicle idling being controlled ?",
                      //isRequired: false
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: airQualityManagementRadioBtn2,
                      radioSelectedValue: selectedValueairQualityManagement2,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueairQualityManagement2 = selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),

                    // Q3
                    const FieldLableWidget(
                      lable: "Is excessive noise being controlled ?",
                      // isRequired: true,
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: airQualityManagementRadioBtn3,
                      radioSelectedValue: selectedValueairQualityManagement3,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueairQualityManagement3 = selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              // Container(height: 1000, width: 50, color: Colors.red),
            ],
          ),
        ),

        // Archaeology
        Padding(
          // padding: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),

          child: ExpanstionTileWidget(
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            // padding: const EdgeInsets.only(top: 15),
            isExpanded: false,
            expanstionTitle: 'Archaeology',
            suffixWidget: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    activeColor: AppColors.appPrimaryColor,
                    value: _archaeologyIsChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _archaeologyIsChecked = value ?? false;
                        if (_archaeologyIsChecked) {
                          selectedValueArchaeology1 = archaeologyRadioBtn1
                              .firstWhere(
                                (item) => item.name == "Not Applicable",
                              );
                        } else {
                          selectedValueArchaeology1 = null;
                        }
                      });
                    },
                  ),
                  const Text(
                    "Not Applicable",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),

            widgetList: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(),

                    // Q1
                    const FieldLableWidget(
                      lable:
                          "Is the site known for high archeological potential ?",
                      // isRequired: true,
                      padding: EdgeInsets.only(left: 15),
                    ),
                    RadioButtonWidget(
                      radioItems: archaeologyRadioBtn1,
                      radioSelectedValue: selectedValueArchaeology1,
                      direction: RadioType.vertical,
                      activeColor: AppColors.appPrimaryColor,
                      isRequired: true,
                      showError: false,

                      onChange: (newValue) async {
                        final selectedItem = newValue as DropdownItemModel;

                        // Immediately update selection (including "No")
                        setState(() {
                          selectedValueArchaeology1 = selectedItem;
                        });

                        // If selected is "No", open the form screen
                        if (selectedItem.name.toLowerCase() == 'no') {
                          final uniqueId = DateTime.now().millisecondsSinceEpoch
                              .toString();

                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaDescriptionScreen(uniqueId: uniqueId),
                                ),
                              );

                          if (result != null && result.isNotEmpty) {
                            submittedCorrectiveActions.add(result);
                            // Optionally store the result tied to this radio question
                            // e.g., map it by question key, or just print/log
                            print('Corrective action submitted: $result');
                          } else {
                            // User cancelled or didn't submit, reset selection (optional)
                            // Uncomment if needed:
                            // setState(() {
                            //   selectedValueAdministratorControls1 = null;
                            // });
                          }
                        }
                      },
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Environmental inspecion radio btn
        Container(
          // elevation: 5,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 10,
            bottom: 0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: FieldLableWidget(
                    lable:
                        "Has this Environmental Inspection indentified an Environmental Incident ?",
                    textStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    // isRequired: true,
                    padding: EdgeInsets.only(left: 15),
                  ),
                ),

                RadioButtonWidget(
                  radioItems: environmentalInspectionRadioBtn,
                  radioSelectedValue: selectedValueEnvironmentalInspection,
                  direction: RadioType.vertical,
                  activeColor: AppColors.appPrimaryColor,
                  isRequired: true,
                  showError: false,
                  onChange: (newValue) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {
                          selectedValueEnvironmentalInspection =
                              newValue as DropdownItemModel;
                          if (selectedValueEnvironmentalInspection?.name
                                  .toLowerCase() ==
                              "no") {
                            selectedEnvironmentalIncident = null;
                          }
                        });
                      }
                    });
                  },

                  textStyle: const TextStyle(fontSize: 14),
                ),
                if (selectedValueEnvironmentalInspection?.name.toLowerCase() ==
                    "yes")
                  DropdownListWidget(
                    margin: EdgeInsets.symmetric(),
                    selected: selectedEnvironmentalIncident,
                    isRequired: false,
                    items: environmentalIncidentItems,
                    onChange: (value) async {
                      selectedEnvironmentalIncident = value;
                      setState(() {});
                    },
                  ),
                if (selectedEnvironmentalIncident?.name == "Other")
                  TextAreaWidget(
                    padding: EdgeInsets.all(0),
                    minLines: 2,
                    height: 60,
                    maxLength: 500,
                    // showCounterText: true,
                    // isRequired: true,
                    hintText: "Maximum charcter limit is 500",
                    controller: siteNameController,
                    lable: "",
                    onChange: (value) {},
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
