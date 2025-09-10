import 'package:custom_widgets/model/dropdown_item_model.dart';

class AviationOccurrenceModel {
  DropdownItemModel? occType;
  DropdownItemModel? occCategory;
  DropdownItemModel? occSubcategory;
  DropdownItemModel? occSubcategory2;
  DropdownItemModel? occLocation;
  String? occLocationText;
  DropdownItemModel? flightStage;
  DropdownItemModel? missionPurpose;
  String? otherMissionPurpose;
  String? temperature;
  String? windSpeed;
  DropdownItemModel? windDirection;
  DropdownItemModel? wasInjury;
  DropdownItemModel? wasPropertyImpact;
  DropdownItemModel? wasEnvImpact;
  DropdownItemModel? wereVehEquipInvolved;
  DropdownItemModel? topography;
  DropdownItemModel? primaryAircraftType;
  String? primaryAircraftTypeStr;
  String? aircraftReg;
  String? company;
  String? pilotName;
  DropdownItemModel? additionalAircraftType;
  String? addiAircraftTypeStr;
  String? eventDesc;
  DropdownItemModel? photosAttached;
  DropdownItemModel? aircraftDamage;
  DropdownItemModel? injuries;
  String? complForestAreaDesc;
  DropdownItemModel? compforestAreaOfficer;
  String? addAirRegistration;
  String? addCompany;

  AviationOccurrenceModel({
    this.occType,
    this.occCategory,
    this.occSubcategory,
    this.occSubcategory2,
    this.occLocation,
    this.occLocationText,
    this.flightStage,
    this.missionPurpose,
    this.otherMissionPurpose,
    this.temperature,
    this.windSpeed,
    this.windDirection,
    this.wasInjury,
    this.wasPropertyImpact,
    this.wasEnvImpact,
    this.wereVehEquipInvolved,
    this.topography,
    this.primaryAircraftType,
    this.primaryAircraftTypeStr,
    this.aircraftReg,
    this.company,
    this.pilotName,
    this.additionalAircraftType,
    this.addiAircraftTypeStr,
    this.eventDesc,
    this.photosAttached,
    this.aircraftDamage,
    this.injuries,
    this.complForestAreaDesc,
    this.compforestAreaOfficer,
    this.addAirRegistration,
    this.addCompany,
  });
}
