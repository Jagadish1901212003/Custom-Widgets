import 'package:custom_widgets/model/dropdown_item_model.dart';

class MotorVehicleAccidentModel {
  DropdownItemModel? vehicleEquipment;
  DropdownItemModel? vehicleOwnership;
  int? unitId;
  String? unitName;
  String? unitSerial;
  String? otherUnit;
  String? model;
  String? primaryContact;
  DropdownItemModel? vehicleType;
  String? vehicleTypeName;
  DropdownItemModel? vehicleUsedAtIncidentTime;
  DropdownItemModel? vehicleDamaged;
  List<DropdownItemModel>? typeOfDamaged;
  String? vehicleUsePurpose;
  DropdownItemModel? wasInjury;
  DropdownItemModel? wasPropertyImpact;
  DropdownItemModel? wasEnvImpact;
  DropdownItemModel? wasAircraftInvolved;
  String? year;
  String? make;
  DropdownItemModel? equipmentDamaged;
  DropdownItemModel? equipmentType;
  DropdownItemModel? equipUsedAtIncidentTime;
  String? licensePlate;
  String? whrVehicleInspected;
  DropdownItemModel? travelDirection;
  DropdownItemModel? mechanicalFailure;
  String? descMechanicalFailure;
  String? describeDamage;
  String? color;
  DropdownItemModel? maneuver;
  String? otherManeuver;

  //Operator details
  // Operator? operator;
  //Passenger details
  // List<PassengerDetails> passengerDetails;
  //Condition Details
  DropdownItemModel? weatherCondition;
  String? speed;
  String? temperature;
  DropdownItemModel? lighCondition;
  DropdownItemModel? roadType;
  DropdownItemModel? roadSurface;
  DropdownItemModel? roadType2;
  DropdownItemModel? roadSurface2;
  //Describe Mobile Vehicle Incident
  String? motorVehicleImgStr;

  MotorVehicleAccidentModel({
    this.vehicleEquipment,
    this.vehicleOwnership,
    this.unitName,
    this.unitSerial,
    this.unitId,
    this.model,
    this.primaryContact,
    this.vehicleType,
    this.vehicleUsedAtIncidentTime,
    this.vehicleDamaged,
    this.typeOfDamaged,
    this.vehicleUsePurpose,
    this.wasInjury,
    this.wasPropertyImpact,
    this.wasEnvImpact,
    this.wasAircraftInvolved,
    this.year,
    this.make,
    this.equipmentDamaged,
    this.equipmentType,
    this.equipUsedAtIncidentTime,
    this.licensePlate,
    this.whrVehicleInspected,
    this.travelDirection,
    this.mechanicalFailure,
    this.descMechanicalFailure,
    this.describeDamage,
    this.color,
    this.maneuver,
    this.otherManeuver,
    // //Operator details
    // this.operator,

    //Passenger details
    // required this.passengerDetails,

    //Condition Details
    this.weatherCondition,
    this.speed,
    this.temperature,
    this.lighCondition,
    this.roadType,
    this.roadSurface,
    this.roadType2,
    this.roadSurface2,
    //Describe Mobile Vehicle Incident
    this.motorVehicleImgStr,
  });
}

// class Operator {
//   String? name;
//   String? email;
//   String? phoneNumber;
//   DropdownItemModel? wasSeatBeltWorn;
//   String? worksite;
//   DropdownItemModel? operatorInjured;
// }
