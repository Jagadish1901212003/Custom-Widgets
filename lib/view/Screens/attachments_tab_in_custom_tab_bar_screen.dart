import 'dart:io';
import 'package:custom_widgets/custom_widget/core/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class AttachmentsTabInCustomTabBarScreen extends StatefulWidget {
  const AttachmentsTabInCustomTabBarScreen({super.key});

  @override
  State<AttachmentsTabInCustomTabBarScreen> createState() =>
      _AttachmentsTabInCustomTabBarScreenState();
}

class _AttachmentsTabInCustomTabBarScreenState
    extends State<AttachmentsTabInCustomTabBarScreen> {
  List<File> documentFiles = [];
  List<File> photoFiles = [];

  final String _docKey = 'document_paths';
  final String _photoKey = 'photo_paths';

  @override
  void initState() {
    super.initState();
    _loadSavedFiles();
  }

  Future<void> _loadSavedFiles() async {
    final prefs = await SharedPreferences.getInstance();
    final docPaths = prefs.getStringList(_docKey) ?? [];
    final photoPaths = prefs.getStringList(_photoKey) ?? [];

    final validDocs = docPaths.where((p) => File(p).existsSync()).toList();
    final validPhotos = photoPaths.where((p) => File(p).existsSync()).toList();

    setState(() {
      documentFiles = validDocs.map((p) => File(p)).toList();
      photoFiles = validPhotos.map((p) => File(p)).toList();
    });
  }

  Future<File> _saveFilePermanently(PlatformFile file, String subfolder) async {
    final appDir = await getApplicationDocumentsDirectory();
    final saveDir = Directory('${appDir.path}/attachments/$subfolder');

    if (!(await saveDir.exists())) {
      await saveDir.create(recursive: true);
    }

    final newPath = path.join(saveDir.path, file.name);
    return File(file.path!).copy(newPath);
  }

  Future<void> _pickFiles({required bool isDocument}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: isDocument
          ? ['pdf', 'xlsx', 'xls', 'docx', 'doc', 'csv']
          : ['png', 'jpeg', 'jpg'],
    );

    if (result != null && result.files.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      final key = isDocument ? _docKey : _photoKey;
      final currentPaths = prefs.getStringList(key) ?? [];

      List<File> newFiles = [];

      for (var file in result.files) {
        double sizeInMB = file.size / (1024 * 1024);
        if ((isDocument && sizeInMB <= 50) || (!isDocument && sizeInMB <= 10)) {
          final savedFile = await _saveFilePermanently(
            file,
            isDocument ? "documents" : "photos",
          );

          if (!currentPaths.contains(savedFile.path)) {
            currentPaths.add(savedFile.path);
            newFiles.add(savedFile);
          }
        }
      }

      await prefs.setStringList(key, currentPaths);

      setState(() {
        if (isDocument) {
          documentFiles.addAll(newFiles);
        } else {
          photoFiles.addAll(newFiles);
        }
      });
    }
  }

  void _showUploadOptions(bool isDocument) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  // TODO: Implement camera capture
                },
              ),
              ListTile(
                leading: const Icon(Icons.folder),
                title: const Text('Choose from storage'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickFiles(isDocument: isDocument);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _onFileTap(File file, bool isDocument) {
    if (isDocument) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Can't preview this file")));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ImagePreviewScreen(imageFile: file)),
      );
    }
  }

  Future<void> _deleteFile(File file, bool isDocument) async {
    final prefs = await SharedPreferences.getInstance();
    final key = isDocument ? _docKey : _photoKey;
    final currentPaths = prefs.getStringList(key) ?? [];

    if (await file.exists()) {
      await file.delete();
    }

    currentPaths.remove(file.path);
    await prefs.setStringList(key, currentPaths);

    setState(() {
      if (isDocument) {
        documentFiles.removeWhere((f) => f.path == file.path);
      } else {
        photoFiles.removeWhere((f) => f.path == file.path);
      }
    });
  }

  Widget _buildCard({
    required String title,
    required List<File> files,
    required VoidCallback onUploadPressed,
    required bool isDocument,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onUploadPressed,
                icon: const Icon(Icons.upload_file, color: Colors.blue),
                label: const Text(
                  "Upload",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (files.isEmpty)
              SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.insert_drive_file,
                        size: 60,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "No files found",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: onUploadPressed,
                        icon: const Icon(Icons.upload, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        label: const Text(
                          "Upload",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: files.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final file = files[index];
                  final fileName = path.basename(file.path);

                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () => _onFileTap(file, isDocument),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!isDocument)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      file,
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60,
                                    ),
                                  )
                                else
                                  const Icon(
                                    Icons.insert_drive_file,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                const SizedBox(height: 8),
                                Flexible(
                                  child: Text(
                                    fileName,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _deleteFile(file, isDocument),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
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

  @override
  Widget build(BuildContext context) {
    // backGro
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCard(
            title: "Attach Documents",
            files: documentFiles,
            onUploadPressed: () => _showUploadOptions(true),
            isDocument: true,
          ),
          _buildCard(
            title: "Attach Photos",
            files: photoFiles,
            onUploadPressed: () => _showUploadOptions(false),
            isDocument: false,
          ),
        ],
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
      appBar: CommonAppBar(
        title: "Photo Preview",
        clearBtnVisible: false,
        centerTitle: true,
        onClear: () {},
      ),
      body: Center(child: InteractiveViewer(child: Image.file(imageFile))),
    );
  }
}
