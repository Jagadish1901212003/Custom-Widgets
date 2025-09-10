class EmployeeModel {
  //final int id;
  final String empId;
  final String empName;
  final String email;
  final String division;
  final String unit;
  final String positionName;
  final String positionId;
  final String department;
  final String supervisor;
  final String branch;
  final String worksite;
  final String supervisorAtInciTime;
  final String supervisorAtInciTimeId;
  final String supervisorId;
  final String managerId;
  final String managerName;

  EmployeeModel({
    //required this.id,
    required this.empId,
    required this.empName,
    required this.email,
    required this.division,
    required this.unit,
    required this.positionName,
    required this.positionId,
    required this.department,
    required this.supervisor,
    required this.branch,
    required this.worksite,
    required this.supervisorAtInciTime,
    required this.supervisorAtInciTimeId,
    required this.supervisorId,
    required this.managerId,
    required this.managerName,
    // required this.phone,
  });
}

class UnitModel {
  //final int id;
  final int unitId;
  final String unitName;
  final String unitType;
  final String isEuipment;
  final String vehicleYear;
  final String model;
  final String make;
  final String primaryContact;
  final String licensePlate;
  final String vehicleTypeId;
  //final String vehicleTypeName;

  UnitModel({
    //required this.id,
    required this.unitId,
    required this.unitName,
    required this.unitType,
    required this.isEuipment,
    required this.vehicleYear,
    required this.model,
    required this.make,
    required this.primaryContact,
    required this.licensePlate,
    required this.vehicleTypeId,
    // required this.vehicleTypeName,
  });
}
