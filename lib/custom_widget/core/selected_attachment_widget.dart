import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:custom_widgets/model/attachment_model.dart';
import 'package:custom_widgets/utility/pop_up_dialog_utility.dart';
import 'package:custom_widgets/utility/utility_function.dart';

class SelectedAttachmentWidget extends StatelessWidget {
  final FileModel file;
  final bool isVisibleDelete;
  final void Function() onFileDelete;
  const SelectedAttachmentWidget({
    super.key,
    required this.file,
    required this.isVisibleDelete,
    required this.onFileDelete,
  });

  @override
  Widget build(BuildContext context) {
    //getting thumbnail image by file extension
    Widget docThumbnailIcon = UtilityFunction.getFileIcon(file.extension);

    return GestureDetector(
      onTap: () async {
        String fileName = file.name;
        Uint8List? bytes;
        //checking is file image or not
        bool isFileImage = UtilityFunction.isFileImage(fileName);

        if (isFileImage) {
          List<int> fileInByte = file.data.readAsBytesSync();
          String fileInBase64 = base64Encode(fileInByte);
          bytes = base64.decode(fileInBase64);
        }

        PopUpDialogUtility.showAttachPreviewDialog(
          context: context,
          filename: fileName,
          imageBytes: bytes,
          docThumbnailIcon: !isFileImage ? docThumbnailIcon : null,
          isVisibleDelete: isVisibleDelete,
          buttonCallback: () => onFileDelete(),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(238, 242, 241, 1),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: docThumbnailIcon,
      ),
    );
  }
}
