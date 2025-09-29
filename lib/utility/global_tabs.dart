// singleton.dart
import 'package:custom_widgets/model/attachment_model.dart';
import 'package:custom_widgets/model/dropdown_item_model.dart';
import 'package:custom_widgets/model/incident_details_model.dart';

class GlobalState {
  static final GlobalState _instance = GlobalState._internal();

  List<DropdownItemModel> selectedInspectionType = [];
  List<DropdownItemModel> selectedSiteType = [];
    List<DropdownItemModel> selectedConstructionStatus = [];

  List<DropdownItemModel> selectedWeatherStatus = [];
  List<DropdownItemModel> selectedWindType = [];
  List<DropdownItemModel> selectedGroundCondition = [];
  List<DropdownItemModel> selectedPriorities = [];
  List<DropdownItemModel> selectedCaCategories = [];
  List<DropdownItemModel> selectedStatuses = [];

  //1. Incident Details tab
  IncidentDetailsModel incidentDetails = IncidentDetailsModel(
    reportingBehalfOf: null,
    basicDetailsModel: BasicDetailsModel(),
    reportedBy: null,
    person: [],
  );
  //2. Near Miss tab //empty tab not required

  //3. Injury-Illness tab
  //this is already in person model
  // static InjuryIllness injuryIllness = InjuryIllness(injuredBodyPart: []);

  //9. attachment tab
  List<Attachment> attachments = [];

  factory GlobalState() {
    return _instance;
  }

  GlobalState._internal();
}
