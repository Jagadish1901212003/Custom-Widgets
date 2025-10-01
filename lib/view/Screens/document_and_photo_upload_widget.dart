import 'dart:io';
import 'package:custom_widgets/custom_widget/core/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:custom_widgets/utility/app_colors.dart';

class DocumentAndPhotoUploadWidget extends StatefulWidget {
  final String title;
  final bool isDocument;
  final String storageKey; // SharedPreferences key

  const DocumentAndPhotoUploadWidget({
    super.key,
    required this.title,
    required this.isDocument,
    required this.storageKey,
  });

  @override
  State<DocumentAndPhotoUploadWidget> createState() =>
      _DocumentAndPhotoUploadWidgetState();
}

class _DocumentAndPhotoUploadWidgetState
    extends State<DocumentAndPhotoUploadWidget> {
  List<File> files = [];

  @override
  void initState() {
    super.initState();
    _loadSavedFiles();
  }

  Future<void> _loadSavedFiles() async {
    final prefs = await SharedPreferences.getInstance();
    final paths = prefs.getStringList(widget.storageKey) ?? [];
    final validFiles = <File>[];
    for (var p in paths) {
      final f = File(p);
      if (await f.exists()) validFiles.add(f);
    }
    setState(() => files = validFiles);
  }

  Future<File> _saveFilePermanently(PlatformFile file, String subfolder) async {
    final appDir = await getApplicationDocumentsDirectory();
    final saveDir = Directory('${appDir.path}/attachments/$subfolder');
    if (!(await saveDir.exists())) await saveDir.create(recursive: true);
    final newPath = path.join(saveDir.path, file.name);
    return File(file.path!).copy(newPath);
  }

  Future<void> _pickFiles() async {
    if (!widget.isDocument) {
      // Show options for photos only
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (_) => SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  color: AppColors.appPrimaryColor,
                ),
                title: const Text("Camera"),
                onTap: () async {
                  Navigator.pop(context);
                  final picker = ImagePicker();
                  final XFile? photo = await picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (photo != null) await _addFile(File(photo.path), "photos");
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.folder,
                  color: AppColors.appPrimaryColor,
                ),
                title: const Text("Choose from Storage"),
                onTap: () async {
                  Navigator.pop(context);
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                    allowMultiple: true, // keep multiple selection
                    // remove allowedExtensions for images
                  );
                  if (result != null && result.files.isNotEmpty) {
                    for (var f in result.files) {
                      if (f.path != null) {
                        await _addFile(File(f.path!), "photos");
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      );
    } else {
      // Documents: open file picker directly
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['pdf', 'xlsx', 'xls', 'docx', 'doc', 'csv'],
      );

      if (result != null && result.files.isNotEmpty) {
        for (var f in result.files) await _addFile(File(f.path!), "documents");
      }
    }
  }

  Future<void> _addFile(File file, String subfolder) async {
    final fileName = path.basename(file.path);
    final sizeInMB = await file.length() / (1024 * 1024);

    // Validation
    final ext = fileName.split('.').last.toLowerCase();
    if (widget.isDocument) {
      if (!['pdf', 'xlsx', 'xls', 'docx', 'doc', 'csv'].contains(ext)) return;
      if (sizeInMB > 50) return;
    } else {
      if (!['png', 'jpg', 'jpeg'].contains(ext)) return;
      if (sizeInMB > 10) return;
    }
    if (fileName.length > 200) return;

    final savedFile = await _saveFilePermanently(
      PlatformFile(name: fileName, path: file.path, size: await file.length()),
      subfolder,
    );

    final prefs = await SharedPreferences.getInstance();
    final currentPaths = prefs.getStringList(widget.storageKey) ?? [];
    if (!currentPaths.contains(savedFile.path)) {
      currentPaths.add(savedFile.path);
    }
    await prefs.setStringList(widget.storageKey, currentPaths);

    setState(() => files.add(savedFile));
  }

  Future<void> _deleteFile(File file) async {
    final prefs = await SharedPreferences.getInstance();
    final currentPaths = prefs.getStringList(widget.storageKey) ?? [];

    if (await file.exists()) await file.delete();
    currentPaths.remove(file.path);
    await prefs.setStringList(widget.storageKey, currentPaths);

    setState(() => files.removeWhere((f) => f.path == file.path));
  }

  void _openPreview(File file) {
    if (!widget.isDocument) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ImagePreviewScreen(imageFile: file)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpanstionTileWidget(
          collapsedBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          // padding: const EdgeInsets.only(top: 15),
          isExpanded: false,
          expanstionTitle: widget.title,
          titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          suffixWidget: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
            child: ElevatedButton.icon(
              onPressed: _pickFiles,
              icon: const Icon(
                Icons.add,
                size: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // border radius of 5
                ),
              ),
              label: const Text(
                "Upload",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          widgetList: [docAndPhotoCard()],
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget docAndPhotoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Header
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       widget.title,
            //       style: const TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 18,
            //       ),
            //     ),
            //     ElevatedButton.icon(
            //       onPressed: _pickFiles,
            //       icon: const Icon(Icons.add, size: 18, color: Colors.white),
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: AppColors.appPrimaryColor,
            //       ),
            //       label: const Text(
            //         "Upload",
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 12),
            // Empty state
            if (files.isEmpty) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 228, 224, 224),
                ),
                child: const Icon(
                  Icons.insert_drive_file,
                  size: 40,
                  color: AppColors.appPrimaryColor,
                ),
              ),
              const Text(
                "No files attached",
                style: TextStyle(color: Colors.grey),
              ),
            ] else
              // File list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: files.length,
                itemBuilder: (ctx, i) {
                  final file = files[i];
                  final fileName = path.basename(file.path);

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: widget.isDocument
                          ? const Icon(
                              Icons.insert_drive_file,
                              color: AppColors.appPrimaryColor,
                            )
                          : Image.file(
                              file,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                      title: Text(fileName, overflow: TextOverflow.ellipsis),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.appPrimaryColor,
                        ),
                        onPressed: () => _deleteFile(file),
                      ),
                      onTap: () => _openPreview(file),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

// -------------------- Image Preview Screen ------------------------
class ImagePreviewScreen extends StatelessWidget {
  final File imageFile;
  const ImagePreviewScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Preview"),
        backgroundColor: AppColors.appPrimaryColor,
      ),
      body: Center(child: InteractiveViewer(child: Image.file(imageFile))),
    );
  }
}
