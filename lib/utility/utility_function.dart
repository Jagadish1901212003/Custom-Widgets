// import 'dart:io';
// import 'dart:math';
// import 'package:custom_widgets/model/dropdown_item_model.dart';
// import 'package:custom_widgets/utility/app_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_constants.dart';

class UtilityFunction {
  //   static Future<List<DropdownItemModel>> getDropdownItemModelDataFromMaster({
  //     required String type,
  //     String? whereByColumn,
  //     int? whereByValue,
  //     String? orderBy,
  //   }) async {
  //     List<DropdownItemModel> listdata = [];
  //     List<Map<String, dynamic>> data;
  //     if (whereByValue == null) {
  //       //data = await LocalDBHelper.getMasterData(type: type, orderBy: orderBy);
  //     } else {
  //       // data = await LocalDBHelper.getMasterDataByWhere(
  //       //   type: type,
  //       //   column: whereByColumn ?? "",
  //       //   value: whereByValue,
  //       // );
  //     }
  //     // if (data.isNotEmpty) {
  //     //   for (int i = 0; i < data.length; i++) {
  //     //     //if STATS is 3221 (DEV) || 4849 (IQA & CQA) then skip it
  //     //     if (data[i]["STATS"] == '3221' || data[i]["STATS"] == '4849') {
  //     //       continue;
  //     //     }
  //     //     DropdownItemModel value = DropdownItemModel(
  //     //       id: i,
  //     //       name: data[i]["TXVAL"].toString().trim(),
  //     //       value: data[i]["UNQID"],
  //     //       data: data[i],
  //     //     );
  //     //     listdata.add(value);
  //     //   }
  //     // }
  //     return listdata;
  //   }

  //   //This is for other than master data injury details
  //   static Future<List<DropdownItemModel>> getDropdownItemModelData({
  //     required String table,
  //     String? whereByColumn,
  //     int? whereByValue,
  //     required String orderBy,
  //   }) async {
  //     List<DropdownItemModel> listdata = [];
  //     List<Map<String, dynamic>> data;
  //     if (whereByColumn == null) {
  //       // print('get all records....');
  //       // data = await LocalDBHelper.getAllRecords(table, orderBy);
  //     } else {
  //       //  print('get all records by where....');
  //       // data = await LocalDBHelper.getRecordsByWhere(
  //       //   table,
  //       //   whereByColumn,
  //       //   whereByValue,
  //       //   orderBy,
  //       // );
  //     }

  //     // if (data.isNotEmpty) {
  //     //   if (table == DbConstants.NATURE_OF_INJURY_TBL) {
  //     //     //  print('in table NATURE_OF_INJURY_TBL....');
  //     //     for (int i = 0; i < data.length; i++) {
  //     //       DropdownItemModel value = DropdownItemModel(
  //     //         id: i,
  //     //         name: data[i]["TXVAL"].toString().trim(),
  //     //         value: data[i]["NATID"],
  //     //         data: data[i],
  //     //       );
  //     //       listdata.add(value);
  //     //     }
  //     //   } else if (table == DbConstants.INJURE_SIDE_TBL) {
  //     //     // print('in table INJURE_SIDE_TBL....');
  //     //     for (int i = 0; i < data.length; i++) {
  //     //       DropdownItemModel value = DropdownItemModel(
  //     //         id: i,
  //     //         name: data[i]["TXVAL"].toString().trim(),
  //     //         value: data[i]["SIDID"],
  //     //         data: data[i],
  //     //       );
  //     //       listdata.add(value);
  //     //     }
  //     //   } else {
  //     //     // print('in table ELSE....');
  //     //     for (int i = 0; i < data.length; i++) {
  //     // DropdownItemModel value = DropdownItemModel(
  //     //   id: i,
  //     //   name: data[i]["TXVAL"].toString().trim(),
  //     //   value: data[i]["UNQID"],
  //     //   data: data[i],
  //     // );
  //     //       listdata.add(value);
  //     //     }
  //     //   }
  //     // }
  //     return listdata;
  //   }

  static IconData getIcon(int typeId) {
    // print("typeId :::: $typeId ::::: ${IncidentType.nearMissId}");
    IconData icon = Icons.abc;

    switch (typeId) {
      case IncidentType.nearMissId:
        icon = Icons.search_off;
        break;
      case IncidentType.injuryIllnessId:
        icon = Icons.personal_injury_outlined;
        break;
      case IncidentType.motorVehicleAccidentId:
        icon = Icons.car_crash;
        break;
      case IncidentType.propertyDamageId:
        icon = Icons.location_city;
        break;
      case IncidentType.environmentId:
        icon = Icons.energy_savings_leaf_outlined;
        break;

      case IncidentType.hazardId:
        icon = Icons.add_task;
        break;

      case IncidentType.attachmentId:
        icon = Icons.attachment;
        break;
    }
    return icon;
  }

  //   static String getCurrentDate() {
  //     return DateFormat('yyyy-MM-dd').format(DateTime.now());
  //   }

  //   static String getCurrentTime() {
  //     return DateFormat('HH:mm:ss').format(DateTime.now());
  //   }

  //   static String getDateString(DateTime? date) {
  //     var dateString = "";
  //     if (date != null) {
  //       dateString = DateFormat('yyyy-MM-dd').format(date);
  //     }
  //     return dateString;
  //   }

  //   static String getDateDiffrenceInDays(DateTime? date1, DateTime? date2) {
  //     if (date1 == null || date2 == null) {
  //       return "";
  //     }

  //     Duration difference = date2.difference(date1);

  //     int inDays = difference.inDays;
  //     int hours = difference.inHours % 24;
  //     int minutes = difference.inMinutes % 60;
  //     int seconds = difference.inSeconds % 60;
  //     return "$inDays Days $hours:$minutes:$seconds";
  //   }

  //   static bool isIncidentDateTimeValid(
  //     String time1,
  //     String time2,
  //     DateTime? incidentDate,
  //   ) {
  //     bool isValid = false;
  //     DateTime now = DateTime.now();

  //     String nowDateString = DateFormat('yyyy-MM-dd').format(now);
  //     String incidentDateString = DateFormat(
  //       'yyyy-MM-dd',
  //     ).format(incidentDate ?? now);

  //     print("nowDateString:$nowDateString");
  //     print("incidentDateString:$incidentDateString");

  //     DateTime date1 = DateTime.parse("$incidentDateString $time1");
  //     DateTime date2 = DateTime.parse("$nowDateString $time2");

  //     print("date1 $date1");
  //     print("date2 $date2");

  //     if (date1.isBefore(date2)) {
  //       print("incident date is before true");
  //       isValid = true;
  //     }
  //     return isValid;
  //   }

  //   static bool isIncidentDateEnVTimeValid(DateTime? date1, DateTime? date2) {
  //     bool isValid = false;

  //     print("date1 $date1");
  //     print("date2 $date2");

  //     if (date1!.isBefore(date2!) || date1.isAtSameMomentAs(date2)) {
  //       print("incident date is before true");
  //       isValid = true;
  //     }
  //     return isValid;
  //   }

  static Future<String> generateUniqueId() async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toRadixString(16);
    String randomPart = (Random().nextDouble() + 1)
        .toStringAsFixed(10)
        .substring(2);
    return (timestamp + randomPart).substring(0, 20);
  }

  //   static String getFormattedDate(String visitTimestamp) {
  //     if (visitTimestamp != "") {
  //       DateTime dateTime = DateTime.parse(visitTimestamp);
  //       String displayDate = DateFormat('E, MMM dd, yyyy').format(dateTime);
  //       return displayDate;
  //     } else {
  //       return "";
  //     }
  //   }

  static Icon getFileIcon(String extension, {double size = 50}) {
    final ext = extension.toLowerCase();

    if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(ext)) {
      return Icon(Icons.image, size: size, color: Colors.blue);
    } else if (ext == 'pdf') {
      return Icon(Icons.picture_as_pdf, size: size, color: Colors.red);
    } else if (['doc', 'docx'].contains(ext)) {
      return Icon(Icons.description, size: size, color: Colors.indigo);
    } else if (['xls', 'xlsx'].contains(ext)) {
      return Icon(Icons.grid_on, size: size, color: Colors.green);
    } else if (['ppt', 'pptx'].contains(ext)) {
      return Icon(Icons.slideshow, size: size, color: Colors.orange);
    } else if (['txt', 'rtf', 'md'].contains(ext)) {
      return Icon(Icons.notes, size: size, color: Colors.grey);
    } else if (['zip', 'rar', '7z', 'tar', 'gz'].contains(ext)) {
      return Icon(Icons.archive, size: size, color: Colors.brown);
    } else {
      return Icon(Icons.insert_drive_file, size: size, color: Colors.grey);
    }
  }

  static bool isFileImage(String fileName) {
    bool isImage = false;
    var extension = fileName.split('.').last.toLowerCase();
    if (extension == FileExtension.png ||
        extension == FileExtension.jpg ||
        extension == FileExtension.jpeg) {
      isImage = true;
    }
    return isImage;
  }

  //   static bool isValidEmail(String email) {
  //     bool isValid = false;
  //     if (email.isNotEmpty) {
  //       isValid = RegExp(
  //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  //       ).hasMatch(email);
  //     }
  //     return isValid;
  //   }

  //   // -------"Date/7582356823756/" to Mar 26,2024----------
  //   static String getFormattedDateFromMillisecondsSinceEpoch(String epochDate) {
  //     DateTime dateTime = DateTime.now();
  //     var aStr = epochDate.replaceAll(RegExp(r'[^0-9]'), '');
  //     int aInt = int.parse(aStr);
  //     dateTime = DateTime.fromMillisecondsSinceEpoch(aInt);
  //     String displayDate = DateFormat('MMM dd, yyyy').format(dateTime);
  //     return displayDate;
  //   }

  //   static Future<List<int>> readBinaryFile(File file) async {
  //     List<int> bytes = await file.readAsBytes();
  //     print("File size: ${bytes.length} bytes");
  //     return bytes;

  //     // Example: encode to base64 if needed
  //     // import 'dart:convert';
  //     // String base64Str = base64Encode(bytes);
  //   }

  static bool isValidateEmail(String? value) {
    const pattern = r'^[\w\.-]+@[\w\.-]+\.\w{2,}$';
    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value) ? false : true;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
