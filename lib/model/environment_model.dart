import 'package:custom_widgets/model/dropdown_item_model.dart';

class EnvironmentModel {
  DropdownItemModel? envImpactLocation;
  List<DropdownItemModel> envImpact;
  String? otherEnvImpact;
  String? envImpactDesc;
  String? descLocSurrArea;
  DropdownItemModel? wasInjury;
  DropdownItemModel? wasPropertyImpact;
  DropdownItemModel? wereVehicleEuipInvolved;
  DropdownItemModel? wasAircraftInvolved;
  DropdownItemModel? spillRelease;
  List<DropdownItemModel> releasedTo;
  DropdownItemModel? stateSubstanceRelease;
  DropdownItemModel? typeSubstanceRelease;
  String? otherTypeSubRelease;
  String? commerNameSubstance;
  String? estQtySubReleased;
  DropdownItemModel? unitMeasurement;
  DropdownItemModel? concentrationKnown;
  String? concentration;
  DropdownItemModel? wasreleasedContained;
  String? rateRelease;
  String? epaReference;
  DateTime? startDtRelease;
  DateTime? endDtRelease;
  //String? startDtReleaseStr;
  //String? endDtReleaseStr;
  String? startTimeRelease;
  String? endTimeRelease;
  String? duration;
  String? otherSubDetails;

  EnvironmentModel({
    this.envImpactLocation,
    required this.envImpact,
    this.otherEnvImpact,
    this.envImpactDesc,
    this.descLocSurrArea,
    this.wasInjury,
    this.wasPropertyImpact,
    this.wereVehicleEuipInvolved,
    this.wasAircraftInvolved,
    this.spillRelease,
    required this.releasedTo,
    this.stateSubstanceRelease,
    this.typeSubstanceRelease,
    this.otherTypeSubRelease,
    this.commerNameSubstance,
    this.estQtySubReleased,
    this.unitMeasurement,
    this.concentrationKnown,
    this.concentration,
    this.wasreleasedContained,
    this.rateRelease,
    this.epaReference,
    this.startDtRelease,
    this.endDtRelease,
    // this.startDtReleaseStr,
    // this.endDtReleaseStr,
    this.startTimeRelease,
    this.endTimeRelease,
    this.duration,
    this.otherSubDetails,
  });
}

// class SanctionScrutiny {
//   int id;
//   DropdownItemModel? regulatory;
//   DropdownItemModel? client;
//   DropdownItemModel? legalPublic;
//   String? description;
//   SanctionScrutiny({
//     required this.id,
//     this.regulatory,
//     this.client,
//     this.legalPublic,
//     this.description,
//   });
// }
