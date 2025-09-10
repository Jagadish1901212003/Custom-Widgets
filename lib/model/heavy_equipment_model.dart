import 'package:custom_widgets/model/dropdown_item_model.dart';

//equipment
class HeavyEquipmentModel {
  List<EquipmentDetails> equipmentDetails;
  HeavyEquipmentModel({required this.equipmentDetails});
}

class EquipmentDetails {
  int id;
  DropdownItemModel? equipmentOwner;
  List<DropdownItemModel> machineType;
  String? estCostOfRepairReplacement;
  String? estCostOfThirdPartyDamage;
  String? damageDescription;

  EquipmentDetails({
    required this.id,
    this.equipmentOwner,
    required this.machineType,
    this.estCostOfRepairReplacement,
    this.estCostOfThirdPartyDamage,
    this.damageDescription,
  });
}
