import 'package:custom_widgets/model/attachment_model.dart';
import 'package:custom_widgets/model/dropdown_item_model.dart';
import 'package:custom_widgets/model/employee_model.dart';
import 'package:custom_widgets/model/injurey_illness_model.dart';
import 'package:custom_widgets/model/motor_vehicle_accident_model.dart';

class IncidentDetailsModel {
  DropdownItemModel? reportingBehalfOf;
  Person? reportedBy;
  BasicDetailsModel? basicDetailsModel;
  List<Person> person;

  IncidentDetailsModel({
    this.reportingBehalfOf,
    this.reportedBy,
    this.basicDetailsModel,
    required this.person,
  });
}

class ReportedByModel {
  String? reportedByName;
  String? reportedByIdNo;
  String? email;
  String? division;
  String? unit;
  String? positionName;
  String? positionId;
  String? department;
  String? supervisor;
  String? branch;
  String? worksite;
  DropdownItemModel? supervisorAtInciTime;

  ReportedByModel({
    this.reportedByName,
    this.reportedByIdNo,
    this.email,
    this.division,
    this.unit,
    this.positionName,
    this.positionId,
    this.department,
    this.supervisor,
    this.branch,
    this.worksite,
    this.supervisorAtInciTime,
  });
}

class BasicDetailsModel {
  DateTime? incidentDate;
  String? incidentTime;
  String? dateOfIncReported;
  String? timeOfIncReported;
  DropdownItemModel? locationType;
  String? locationTypeDesc;
  DropdownItemModel? workHrs;
  String? locationAddress;
  String? latitude;
  String? longitude;
  String? locationAddressDesc;
  String? incDescription;
  String? immediateActionsToMakeSafe;
  DropdownItemModel? securityIncident;
  DropdownItemModel? wereEmergencyServiceContacted;
  String? whichEmergencyServiceContacted;
  DropdownItemModel? werePoliceNotified;
  String? policeFileNumber;
  String? empSignature;
  String? signatureDate;
  String? nearestMunicipality;

  BasicDetailsModel({
    this.incidentDate,
    this.incidentTime,
    this.dateOfIncReported,
    this.timeOfIncReported,
    this.locationType,
    this.locationTypeDesc,
    this.workHrs,
    this.locationAddress,
    this.latitude,
    this.longitude,
    this.locationAddressDesc,
    this.incDescription,
    this.immediateActionsToMakeSafe,
    this.securityIncident,
    this.wereEmergencyServiceContacted,
    this.whichEmergencyServiceContacted,
    this.werePoliceNotified,
    this.policeFileNumber,
    this.empSignature,
    this.signatureDate,
    this.nearestMunicipality,
  });
}

class Person {
  int id;
  String uniqueId;
  DropdownItemModel? goAEmployee;
  DropdownItemModel? nonEmployeeGroup;
  List<DropdownItemModel> role;
  String? employeeName;
  String? employeeId;
  String? supervisor;
  String? supervisorId;
  String? managerId;
  String? managerName;
  String? supervisor2;
  String? supervisor2Id;
  String? positionId;
  String? positionName;
  String? worksite;
  String? phone;
  String? email;
  String? division;
  String? department;
  String? branch;
  String? unit;
  InjuryIllness injuryIllness;
  MotorVehicleAccidentModel motorVehicleAccidentModel;
  //JourneyPlan journeyPlan;
  Operator? operator;
  List<PassengerDetails> passengerDetails;

  List<Attachment> recordedStatement;
  //
  bool isDefaultUser;
  //flags for tabs data handle
  bool isInjured;
  bool isDriver;
  bool firstAider;
  bool isOperator;
  EmployeeModel? userData;
  String? additionalPersonInfoData;
  String? otherNonEmployeeGroup;

  Person({
    required this.id,
    required this.uniqueId,
    this.goAEmployee,
    this.nonEmployeeGroup,
    this.otherNonEmployeeGroup,
    required this.role,
    this.employeeName,
    this.employeeId,
    this.positionId,
    this.positionName,
    this.worksite,
    this.phone,
    this.email,
    this.supervisor,
    this.supervisorId,
    this.managerId,
    this.managerName,
    this.supervisor2,
    this.supervisor2Id,
    this.division,
    this.department,
    this.branch,
    this.unit,
    required this.injuryIllness,
    required this.motorVehicleAccidentModel,
    this.operator,
    required this.passengerDetails,
    required this.recordedStatement,
    //
    required this.isDefaultUser,
    required this.isInjured,
    required this.isDriver,
    required this.isOperator,
    required this.firstAider,
    this.userData,
    this.additionalPersonInfoData,
  });
}

class Operator {
  String? name;
  String? email;
  String? phone;
  DropdownItemModel? wasSeatBeltWorn;
  String? worksite;
  DropdownItemModel? operatorInjured;

  Operator({
    this.name,
    this.email,
    this.phone,
    this.wasSeatBeltWorn,
    this.worksite,
    this.operatorInjured,
  });
}

class PassengerDetails {
  int id;
  String? nameOfPerson;
  String? empId;
  String? contactNo;
  String? email;
  DropdownItemModel? wasSeatBeltWorn;

  PassengerDetails({
    required this.id,
    this.nameOfPerson,
    this.empId,
    this.contactNo,
    this.email,
    this.wasSeatBeltWorn,
  });
}
