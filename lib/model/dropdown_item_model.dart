class DropdownItemModel {
  int id;
  String name;
  int value;
  dynamic data;
  DropdownItemModel({
    required this.id,
    required this.name,
    required this.value,
    this.data,
  });
}
