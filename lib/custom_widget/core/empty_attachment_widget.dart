import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:custom_widgets/model/attachment_model.dart';
import 'package:custom_widgets/utility/app_constants.dart';
import 'package:custom_widgets/utility/toast_utility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EmptyAttachmentWidget extends StatelessWidget {
  final BuildContext ctx;
  final bool? isEnable;
  final void Function(FileModel) onTapCamera;
  final void Function(FileModel) onTapGallary;

  const EmptyAttachmentWidget({
    super.key,
    required this.ctx,
    this.isEnable = true,
    required this.onTapCamera,
    required this.onTapGallary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!isEnable!) {
          ToastUtility.showErrorMessageFlushBar(
            'You can\'t upload file in view mode. ',
            ctx,
          );
          return;
        }
        await _buildPickImageDialog();
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(253, 253, 253, 1),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Icon(Icons.upload, size: 40, color: Colors.blue),
      ),
    );
  }

  Future<void> _buildPickImageDialog() async {
    return showModalBottomSheet(
      isDismissible: true,
      context: ctx,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 5),
              child: ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                minVerticalPadding: 0,
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Take a photo',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                onTap: () async {
                  _pickImgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 5, bottom: 0),
              child: ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                minVerticalPadding: 0,
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Choose file',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                onTap: () async {
                  _pickFiles();
                  Navigator.of(context).pop();
                },
              ),
            ),
            //for ios device
            if (Platform.isIOS)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 5, bottom: 0),
                child: ListTile(
                  visualDensity: const VisualDensity(
                    horizontal: 0,
                    vertical: -4,
                  ),
                  minVerticalPadding: 0,
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text(
                    'Choose from Gallary',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () async {
                    _pickGallaryForIos();
                    Navigator.of(context).pop();
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _pickImgFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    File selectedFile = File(image?.path ?? "");
    if (selectedFile.path.isNotEmpty) {
      String fileName = selectedFile.path.split('/').last;
      int sizeInBytes = selectedFile.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);

      //This is new code which is working in ios device

      final path = await _localPath;
      final ifile = File('$path/$fileName');
      print("path new ::::::::::::::${ifile.path}");
      print("path new absolute::::::::::::::${ifile.absolute.path}");
      await ifile.writeAsBytes(selectedFile.readAsBytesSync());

      ///////////////////////////////////////////////

      if (sizeInMb <= 10 && fileName.length < 100) {
        print(selectedFile);
        var file = FileModel(
          id: DateTime.now().microsecond,
          name: fileName,
          extension: fileName.split('.').last.toLowerCase(),
          data: ifile, //selectedFile,
        );

        onTapCamera(file);
      } else {
        if (ctx.mounted) {
          ToastUtility.showErrorMessageFlushBar(
            AppString.fileSizeExceedText,
            ctx,
          );
        }
      }
    }
  }

  //html js py

  //var restrictedMedia = ["text/x-python", 'text/html', 'text/javascript', 'application/x-msdownload', 'application/octet-stream']

  //in ios case this needs to use
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: FileExtension.extensions,
      allowCompression: true,
      withReadStream: true,
    );

    if (result != null) {
      final file = result.files.single;
      final extension = file.extension?.toLowerCase(); // normalize to lowercase

      if (extension != null &&
          FileExtension.normalizedExtensions.contains(extension)) {
        //get mime type
        File selectedFile = File(result.files.single.path!);
        if (selectedFile.path.isNotEmpty) {
          String fileName = selectedFile.path.split('/').last;
          int sizeInBytes = selectedFile.lengthSync();
          double sizeInMb = sizeInBytes / (1024 * 1024);
          print("selected file path::::: ${selectedFile.path}");

          //This is new code which is working in ios device

          final path = await _localPath;
          final ifile = File('$path/$fileName');
          print("path new ::::::::::::::${ifile.path}");
          print("path new absolute::::::::::::::${ifile.absolute.path}");
          await ifile.writeAsBytes(selectedFile.readAsBytesSync());

          ///////////////////////////////////////////////

          if (sizeInMb <= 10 && fileName.length < 100) {
            print(selectedFile);
            var file = FileModel(
              id: DateTime.now().microsecond,
              name: fileName,
              extension: fileName.split('.').last.toLowerCase(),
              data: ifile, //selectedFile,
            );
            onTapGallary(file);
          } else {
            if (ctx.mounted) {
              ToastUtility.showErrorMessageFlushBar(
                AppString.fileSizeExceedText,
                ctx,
              );
            }
          }
        }
      } else {
        print("Invalid file extension: $extension");
        if (ctx.mounted) {
          ToastUtility.showErrorMessageFlushBar("Invalid file extension:", ctx);
        }
        // show error
      }
    }
  }

  Future<void> _pickGallaryForIos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.media,
      // allowedExtensions: FileExtension.extensions,
      allowCompression: true,
      withReadStream: true,
    );
    if (result != null) {
      final file = result.files.single;
      final extension = file.extension?.toLowerCase(); // normalize to lowercase
      if (extension != null &&
          FileExtension.normalizedExtensions.contains(extension)) {
        //get mime type
        File selectedFile = File(result.files.single.path!);
        if (selectedFile.path.isNotEmpty) {
          String fileName = selectedFile.path.split('/').last;
          int sizeInBytes = selectedFile.lengthSync();
          double sizeInMb = sizeInBytes / (1024 * 1024);
          print("selected file path::::: ${selectedFile.path}");

          //This is new code which is working in ios device

          final path = await _localPath;
          final ifile = File('$path/$fileName');
          print("path new ::::::::::::::${ifile.path}");
          print("path new absolute::::::::::::::${ifile.absolute.path}");
          await ifile.writeAsBytes(selectedFile.readAsBytesSync());

          ///////////////////////////////////////////////

          if (sizeInMb <= 10 && fileName.length < 100) {
            print(selectedFile);
            var file = FileModel(
              id: DateTime.now().microsecond,
              name: fileName,
              extension: fileName.split('.').last.toLowerCase(),
              data: ifile, //selectedFile,
            );
            onTapGallary(file);
            // //Temp code to upload attachment to CMIS
            // // This is just for testing purpose, you can remove this later
            // await AttachmentRepository()
            //     .uploadAttachmentToCmis("", selectedFile.path)
            //     .then((responseBody) {
            //   //update INCID & OBJID
            //   print("ResponseBody from CMIS: ${jsonDecode(responseBody)}");
            // });
          } else {
            if (ctx.mounted) {
              ToastUtility.showErrorMessageFlushBar(
                AppString.fileSizeExceedText,
                ctx,
              );
            }
          }
        }
      } else {
        print("Invalid file extension: $extension");
        if (ctx.mounted) {
          ToastUtility.showErrorMessageFlushBar("Invalid file extension:", ctx);
        }
        // show error
      }
    }
  }
}
