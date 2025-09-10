import 'package:custom_widgets/model/dropdown_item_model.dart';

class PropertyDamageModel {
  List<PropertyDetails> propertyDetails;
  PropertyDamageModel({required this.propertyDetails});
}

class PropertyDetails {
  int id;
  DropdownItemModel? propertyType;
  String? otherPropertyType;
  DropdownItemModel? previousIncident;
  DropdownItemModel? safetyConcerns;
  DropdownItemModel? wasInjury;
  DropdownItemModel? wasEnvImpact;
  DropdownItemModel? wereVehicleEuipInvolved;
  DropdownItemModel? wasAircraftInvolved;
  String? existingDamageDesc;
  String? safetyConcernDesc;
  DropdownItemModel? equipmentType;
  String? otherEquipmentType;

  PropertyDetails({
    required this.id,
    this.propertyType,
    this.otherPropertyType,
    this.previousIncident,
    this.safetyConcerns,
    this.wasInjury,
    this.wasEnvImpact,
    this.wereVehicleEuipInvolved,
    this.wasAircraftInvolved,
    this.existingDamageDesc,
    this.safetyConcernDesc,
    this.equipmentType,
    this.otherEquipmentType,
  });
}
