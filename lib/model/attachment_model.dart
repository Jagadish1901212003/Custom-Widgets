import 'dart:io';
import 'package:custom_widgets/model/dropdown_item_model.dart';

class Attachment {
  final int id;
  final String uniqueId;
  final String docType;
  final String personName;
  final String updatedBy;
  final String updatedDate;
  final String description;
  final DropdownItemModel privacySetting;
  final DropdownItemModel fileType;

  final FileModel file;
  Attachment({
    required this.id,
    required this.uniqueId,
    required this.docType,
    required this.personName,
    required this.updatedBy,
    required this.updatedDate,
    required this.description,
    required this.privacySetting,
    required this.fileType,
    required this.file,
  });
}

class FileModel {
  final int id;
  final String name;
  final String extension;
  final File data;
  FileModel({
    required this.id,
    required this.name,
    required this.extension,
    required this.data,
  });
}
