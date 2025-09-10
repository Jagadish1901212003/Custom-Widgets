import 'package:custom_widgets/model/dropdown_item_model.dart';

class InjuryIllness {
  String? nameOfInjuredPerson;
  String? injuredPersonId;
  String? email;
  String? position;
  String? department;
  String? supervisor;
  DropdownItemModel? isRequireFirstAid;
  DropdownItemModel? isMedicalAssistance;
  DropdownItemModel? isTimeLost;
  DropdownItemModel? isPsychologicalInjury;
  DropdownItemModel? isPropertyDamage;
  DropdownItemModel? isEnvironmentalImpact;
  DropdownItemModel? isEquipmentInvolved;
  DropdownItemModel? isAircraftInvolved;
  DropdownItemModel? isTakenMedFacility;
  String? facilityName;
  String? practionerName;
  String? treatmentDate;
  String? description;

  List<InjuredBodyPart> injuredBodyPart;

  InjuryIllness({
    this.nameOfInjuredPerson,
    this.injuredPersonId,
    this.email,
    this.position,
    this.department,
    this.supervisor,
    this.isRequireFirstAid,
    this.isMedicalAssistance,
    this.isTimeLost,
    this.isPsychologicalInjury,
    this.isPropertyDamage,
    this.isEnvironmentalImpact,
    this.isEquipmentInvolved,
    this.isAircraftInvolved,
    this.isTakenMedFacility,
    this.facilityName,
    this.practionerName,
    this.treatmentDate,
    this.description,
    required this.injuredBodyPart,
  });
}

class InjuredBodyPart {
  int id;
  DropdownItemModel? bodyPart;
  DropdownItemModel? natureOfInjury;
  DropdownItemModel? side;
  String? description;

  InjuredBodyPart({
    required this.id,
    this.bodyPart,
    this.natureOfInjury,
    this.side,
    this.description,
  });
}
