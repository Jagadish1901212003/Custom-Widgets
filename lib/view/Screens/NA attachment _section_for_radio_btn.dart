// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;

// class AttachmentSection extends StatefulWidget {
//   final String title;
//   final bool isDocument;
//   final List<File> files;
//   final ValueChanged<List<File>> onFilesChanged;

//   const AttachmentSection({
//     super.key,
//     required this.title,
//     required this.isDocument,
//     required this.files,
//     required this.onFilesChanged,
//   });

//   @override
//   State<AttachmentSection> createState() => _AttachmentSectionState();
// }

// class _AttachmentSectionState extends State<AttachmentSection> {
//   Future<File> _saveFilePermanently(PlatformFile file, String subfolder) async {
//     final appDir = await getApplicationDocumentsDirectory();
//     final saveDir = Directory('${appDir.path}/attachments/$subfolder');

//     if (!(await saveDir.exists())) {
//       await saveDir.create(recursive: true);
//     }

//     final newPath = path.join(saveDir.path, file.name);
//     return File(file.path!).copy(newPath);
//   }

//   Future<void> _pickFiles() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowMultiple: true,
//       allowedExtensions: widget.isDocument
//           ? ['pdf', 'xlsx', 'xls', 'docx', 'doc', 'csv']
//           : ['png', 'jpeg', 'jpg'],
//     );

//     if (result != null && result.files.isNotEmpty) {
//       List<File> newFiles = [];

//       for (var file in result.files) {
//         double sizeInMB = file.size / (1024 * 1024);
//         if ((widget.isDocument && sizeInMB <= 50) ||
//             (!widget.isDocument && sizeInMB <= 10)) {
//           final savedFile = await _saveFilePermanently(
//             file,
//             widget.isDocument ? "documents" : "photos",
//           );

//           if (!widget.files.any((f) => f.path == savedFile.path)) {
//             newFiles.add(savedFile);
//           }
//         }
//       }

//       if (newFiles.isNotEmpty) {
//         widget.onFilesChanged([...widget.files, ...newFiles]);
//       }
//     }
//   }

//   void _deleteFile(File file) async {
//     if (await file.exists()) {
//       await file.delete();
//     }

//     widget.onFilesChanged(
//       widget.files.where((f) => f.path != file.path).toList(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   widget.title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextButton.icon(
//                   onPressed: _pickFiles,
//                   icon: const Icon(Icons.upload_file, color: AppColors.appPrimaryColor),
//                   label: const Text(
//                     "Upload",
//                     style: TextStyle(fontSize: 14, color: AppColors.appPrimaryColor),
//                   ),
//                 ),
//               ],
//             ),
//             if (widget.files.isEmpty)
//               const Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Center(
//                   child: Text(
//                     "No files attached",
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//               )
//             else
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: widget.files.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 8,
//                   mainAxisSpacing: 8,
//                   childAspectRatio: 1,
//                 ),
//                 itemBuilder: (context, index) {
//                   final file = widget.files[index];
//                   final fileName = path.basename(file.path);

//                   return Stack(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade400),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Center(
//                           child: widget.isDocument
//                               ? Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Icon(
//                                       Icons.insert_drive_file,
//                                       size: 40,
//                                       color: Colors.grey,
//                                     ),
//                                     Text(
//                                       fileName,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(fontSize: 12),
//                                     ),
//                                   ],
//                                 )
//                               : ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.file(
//                                     file,
//                                     fit: BoxFit.cover,
//                                     width: 70,
//                                     height: 70,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 4,
//                         right: 4,
//                         child: GestureDetector(
//                           onTap: () => _deleteFile(file),
//                           child: const CircleAvatar(
//                             radius: 10,
//                             backgroundColor: Colors.black54,
//                             child: Icon(
//                               Icons.close,
//                               size: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class AttachmentSection extends StatefulWidget {
  final String title;
  final bool isDocument;
  final List<File> files;
  final ValueChanged<List<File>> onFilesChanged;

  const AttachmentSection({
    super.key,
    required this.title,
    required this.isDocument,
    required this.files,
    required this.onFilesChanged,
  });

  @override
  State<AttachmentSection> createState() => _AttachmentSectionState();
}

class _AttachmentSectionState extends State<AttachmentSection> {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File> _saveFilePermanently(PlatformFile file, String subfolder) async {
    final appDir = await getApplicationDocumentsDirectory();
    final saveDir = Directory('${appDir.path}/attachments/$subfolder');

    if (!(await saveDir.exists())) {
      await saveDir.create(recursive: true);
    }

    final newPath = path.join(saveDir.path, file.name);
    return File(file.path!).copy(newPath);
  }

  Future<File> _saveXFilePermanently(XFile xfile, String subfolder) async {
    final appDir = await getApplicationDocumentsDirectory();
    final saveDir = Directory('${appDir.path}/attachments/$subfolder');

    if (!(await saveDir.exists())) {
      await saveDir.create(recursive: true);
    }

    final fileName = path.basename(xfile.path);
    final newPath = path.join(saveDir.path, fileName);
    return File(xfile.path).copy(newPath);
  }

  Future<void> _pickFromStorage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: widget.isDocument
          ? ['pdf', 'xlsx', 'xls', 'docx', 'doc', 'csv']
          : ['png', 'jpeg', 'jpg'],
    );

    if (result != null && result.files.isNotEmpty) {
      List<File> newFiles = [];

      for (var file in result.files) {
        final sizeInMB = file.size / (1024 * 1024);
        final fileName = file.name;

        // Validation
        if (fileName.length > 200) continue;
        if (widget.isDocument && sizeInMB > 50) continue;
        if (!widget.isDocument && sizeInMB > 10) continue;

        final savedFile = await _saveFilePermanently(
          file,
          widget.isDocument ? "documents" : "photos",
        );

        if (!widget.files.any((f) => f.path == savedFile.path)) {
          newFiles.add(savedFile);
        }
      }

      if (newFiles.isNotEmpty) {
        widget.onFilesChanged([...widget.files, ...newFiles]);
      }
    }
  }

  Future<void> _pickFromCamera() async {
    final XFile? photo = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (photo != null) {
      final fileName = path.basename(photo.path);
      final file = File(photo.path);

      final sizeInMB = await file.length() / (1024 * 1024);

      // Validation
      if (fileName.length > 200) return;
      if (sizeInMB > 10) return;

      final savedFile = await _saveXFilePermanently(photo, "photos");

      if (!widget.files.any((f) => f.path == savedFile.path)) {
        widget.onFilesChanged([...widget.files, savedFile]);
      }
    }
  }

  void _showUploadOptions() {
    if (widget.isDocument) {
      // Documents → only storage
      _pickFromStorage();
    } else {
      // Photos → show bottom sheet with Camera & Storage
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickFromCamera();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.folder),
                  title: const Text("Choose from storage"),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickFromStorage();
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void _deleteFile(File file) async {
    if (await file.exists()) {
      await file.delete();
    }

    widget.onFilesChanged(
      widget.files.where((f) => f.path != file.path).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: _showUploadOptions,
                  icon: const Icon(Icons.upload_file, color: AppColors.appPrimaryColor),
                  label: const Text(
                    "Upload",
                    style: TextStyle(fontSize: 14, color: AppColors.appPrimaryColor),
                  ),
                ),
              ],
            ),
            if (widget.files.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "No files attached",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.files.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final file = widget.files[index];
                  final fileName = path.basename(file.path);

                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: widget.isDocument
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.insert_drive_file,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      fileName,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    file,
                                    fit: BoxFit.cover,
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _deleteFile(file),
                          child: const CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.black54,
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
