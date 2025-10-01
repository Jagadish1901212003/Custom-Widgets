import 'dart:io';
import 'package:custom_widgets/custom_widget/core/common_app_bar.dart';
import 'package:custom_widgets/custom_widget/core/dropdown_list_widget.dart';
import 'package:custom_widgets/custom_widget/core/field_label_widget.dart';
import 'package:custom_widgets/custom_widget/core/floating_buttons_bottom_bar.dart';
import 'package:custom_widgets/custom_widget/core/search_dropdown_widget.dart';
import 'package:custom_widgets/custom_widget/core/text_area_widget.dart';
import 'package:custom_widgets/custom_widget/core/text_field_widget.dart';
import 'package:custom_widgets/model/dropdown_item_model.dart';
import 'package:custom_widgets/model/employee_model.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/enum.dart';
import 'package:custom_widgets/utility/pop_up_dialog_utility.dart';
import 'package:custom_widgets/view/Screens/document_and_photo_upload_widget.dart';
import 'package:custom_widgets/view/Screens/search_employee_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class CaDescriptionScreen extends StatefulWidget {
  final String uniqueId;
  final Map<String, dynamic>? existingData;

  const CaDescriptionScreen({
    super.key,
    required this.uniqueId,
    this.existingData,
  });

  @override
  State<CaDescriptionScreen> createState() => _CaDescriptionScreenState();
}

class _CaDescriptionScreenState extends State<CaDescriptionScreen> {
  DropdownItemModel? selectedPriorities;
  DropdownItemModel? selectedCaCategories;
  late DropdownItemModel? selectedStatuses = statusDropDown[0];

  late final String _docKey;
  late final String _photoKey;

  List<File> documentFiles = [];
  List<File> photoFiles = [];

  final _formKey = GlobalKey<FormState>();

  EmployeeModel? loginUser;
  EmployeeModel? reportedByDetails1;

  TextEditingController caDescriptionController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController assignToController = TextEditingController();

  final List<DropdownItemModel> priorityDropDown = [
    DropdownItemModel(id: 1, name: "Other", value: 1),
    DropdownItemModel(id: 2, name: "Within 2-3 days", value: 2),
    DropdownItemModel(id: 3, name: "within 24 hours", value: 3),
    DropdownItemModel(id: 4, name: "Within 5-7 days", value: 4),
  ];

  final List<DropdownItemModel> statusDropDown = [
    DropdownItemModel(id: 1, name: "Open", value: 1),
    DropdownItemModel(id: 2, name: "Close", value: 2),
    DropdownItemModel(id: 3, name: "Other", value: 3),
  ];

  final List<DropdownItemModel> caCategoryDropDown = [
    DropdownItemModel(id: 1, name: "ESC-Install", value: 1),
    DropdownItemModel(id: 2, name: "ESC-Maintain", value: 2),
    DropdownItemModel(id: 3, name: "ESC-Remove", value: 3),
    DropdownItemModel(id: 4, name: "Earth Management", value: 4),
    DropdownItemModel(id: 5, name: "Spill Prevention And Install", value: 5),
    DropdownItemModel(id: 6, name: "Surface Water Management", value: 6),
    DropdownItemModel(id: 7, name: "Waste Management", value: 7),
    DropdownItemModel(id: 8, name: "Wildlife mitigration", value: 8),
  ];

  @override
  void initState() {
    super.initState();
    _docKey = 'document_paths_${widget.uniqueId}';
    _photoKey = 'photo_paths_${widget.uniqueId}';
    // _loadSavedFiles();
    _loadExistingData();
  }

  // Future<void> _loadSavedFiles() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final docPaths = prefs.getStringList(_docKey) ?? [];
  //   final photoPaths = prefs.getStringList(_photoKey) ?? [];

  //   List<File> validDocFiles = [];
  //   List<File> validPhotoFiles = [];

  //   for (var p in docPaths) {
  //     final file = File(p);
  //     if (await file.exists()) validDocFiles.add(file);
  //   }
  //   for (var p in photoPaths) {
  //     final file = File(p);
  //     if (await file.exists()) validPhotoFiles.add(file);
  //   }

  //   setState(() {
  //     documentFiles = validDocFiles;
  //     photoFiles = validPhotoFiles;
  //   });
  // }

  void _loadExistingData() {
    final data = widget.existingData;
    if (data == null) return;

    setState(() {
      caDescriptionController.text = data['caDescription'] ?? '';
      notesController.text = data['notes'] ?? '';
      dueDateController.text = data['dueDate'] ?? '';
      assignToController.text = data['assignTo'] ?? '';

      selectedPriorities = priorityDropDown.firstWhere(
        (item) => item.name == data['priority']?.name,
        orElse: () => priorityDropDown.first,
      );

      selectedCaCategories = caCategoryDropDown.firstWhere(
        (item) => item.name == data['caCategory']?.name,
        orElse: () => caCategoryDropDown.first,
      );

      selectedStatuses = statusDropDown.firstWhere(
        (item) => item.name == data['status']?.name,
        orElse: () => statusDropDown.first,
      );
    });
  }

  // Future<File> _saveFilePermanently(PlatformFile file, String subfolder) async {
  //   final appDir = await getApplicationDocumentsDirectory();
  //   final saveDir = Directory('${appDir.path}/attachments/$subfolder');
  //   if (!(await saveDir.exists())) {
  //     await saveDir.create(recursive: true);
  //   }
  //   final newPath = path.join(saveDir.path, file.name);
  //   return File(file.path!).copy(newPath);
  // }

  void setReportedByDetails1(EmployeeModel user) {
    reportedByDetails1 = user;
    assignToController.text = user.empName;
    setState(() {});
  }

  // Future<void> _pickFromCamera() async {
  //   final picker = ImagePicker();
  //   final XFile? photo = await picker.pickImage(source: ImageSource.camera);

  //   if (photo != null) {
  //     final prefs = await SharedPreferences.getInstance();
  //     final key = _photoKey;
  //     final currentPaths = prefs.getStringList(key) ?? [];

  //     final file = File(photo.path);
  //     final fileName = path.basename(file.path);
  //     final sizeInMB = await file.length() / (1024 * 1024);

  //     // ✅ Validation
  //     final ext = fileName.split('.').last.toLowerCase();
  //     if (!['png', 'jpeg', 'jpg'].contains(ext)) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Only PNG, JPEG, JPG allowed")),
  //       );
  //       return;
  //     }
  //     if (sizeInMB > 10) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Image too large! Max 10MB.")),
  //       );
  //       return;
  //     }
  //     if (fileName.length > 200) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("File name too long! Max 200 chars.")),
  //       );
  //       return;
  //     }

  //     final savedFile = await _saveFilePermanently(
  //       PlatformFile(
  //         name: fileName,
  //         path: file.path,
  //         size: await file.length(),
  //       ),
  //       "photos",
  //     );

  //     if (!currentPaths.contains(savedFile.path)) {
  //       currentPaths.add(savedFile.path);
  //       await prefs.setStringList(key, currentPaths);

  //       setState(() => photoFiles.add(savedFile));
  //     }
  //   }
  // }

  // Future<void> _pickFiles({required bool isDocument}) async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowMultiple: true,
  //     allowedExtensions: isDocument
  //         ? ['pdf', 'xlsx', 'xls', 'docx', 'doc', 'csv']
  //         : ['png', 'jpeg', 'jpg'],
  //   );

  //   if (result != null && result.files.isNotEmpty) {
  //     final prefs = await SharedPreferences.getInstance();
  //     final key = isDocument ? _docKey : _photoKey;
  //     final currentPaths = prefs.getStringList(key) ?? [];

  //     List<File> newFiles = [];

  //     for (var file in result.files) {
  //       final sizeInMB = file.size / (1024 * 1024);
  //       final ext = path.extension(file.name).toLowerCase();
  //       final fileName = file.name;

  //       // Validation
  //       if (fileName.length > 200) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text("File name too long! Max 200 chars.")),
  //         );
  //         continue;
  //       }

  //       if (isDocument && sizeInMB > 50) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("$fileName too large! Max 50MB.")),
  //         );
  //         continue;
  //       }
  //       if (!isDocument && sizeInMB > 10) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("$fileName too large! Max 10MB.")),
  //         );
  //         continue;
  //       }

  //       final savedFile = await _saveFilePermanently(
  //         file,
  //         isDocument ? "documents" : "photos",
  //       );

  //       if (!currentPaths.contains(savedFile.path)) {
  //         currentPaths.add(savedFile.path);
  //         newFiles.add(savedFile);
  //       }
  //     }

  //     await prefs.setStringList(key, currentPaths);

  //     setState(() {
  //       if (isDocument) {
  //         documentFiles.addAll(newFiles);
  //       } else {
  //         photoFiles.addAll(newFiles);
  //       }
  //     });
  //   }
  // }

  // void _showUploadOptions(BuildContext context, bool isDocument) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (_) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: [
  //             if (!isDocument) // ✅ Camera only for photos
  //               ListTile(
  //                 leading: const Icon(
  //                   Icons.camera_alt,
  //                   color: AppColors.appPrimaryColor,
  //                 ),
  //                 title: const Text("Camera"),
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                   _pickFromCamera();
  //                 },
  //               ),
  //             ListTile(
  //               leading: const Icon(
  //                 Icons.folder,
  //                 color: AppColors.appPrimaryColor,
  //               ),
  //               title: const Text("Choose from Storage"),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 _pickFiles(isDocument: isDocument);
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future<void> _deleteFile(File file, bool isDocument) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = isDocument ? _docKey : _photoKey;
  //   final currentPaths = prefs.getStringList(key) ?? [];

  //   if (await file.exists()) {
  //     await file.delete();
  //   }

  //   currentPaths.remove(file.path);
  //   await prefs.setStringList(key, currentPaths);

  //   setState(() {
  //     if (isDocument) {
  //       documentFiles.removeWhere((f) => f.path == file.path);
  //     } else {
  //       photoFiles.removeWhere((f) => f.path == file.path);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Add Corrective Action",
        clearBtnVisible: false,
        centerTitle: true,
        onClear: () {},
      ),
      body: SafeArea(
        key: const Key("value"),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CA Description
                TextAreaWidget(
                  isRequired: true,
                  height: 100,
                  // padding: const EdgeInsets.symmetric(horizontal: 15),
                  hintText: "Maximum charcter limit is 500",
                  controller: caDescriptionController,
                  lable: "CA Description",
                  onChange: (value) {},
                ),

                // const SizedBox(height: 10),

                // Priority
                const FieldLableWidget(
                  // padding: EdgeInsets.only(left: 15),
                  lable: "Priority",
                  isRequired: true,
                ),

                // IncidentTypeFormField(
                //   selectedItems: GlobalState().selectedPriorities,
                //   hintText: "Priority",
                //   items: priorityDropDown,
                //   isRequired: true,
                //   onSelect: (selectedTypes, value, isSelected) async {
                //     GlobalState().selectedPriorities = selectedTypes;
                //     await _updateTabs(value, isSelected);
                //   },
                // ),
                DropdownListWidget(
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  selected: selectedPriorities,

                  isRequired: true,
                  items: priorityDropDown,
                  onChange: (value) async {
                    print("Selected name: ${value!.name}");

                    selectedPriorities = value;
                    // isAddEnable();
                  },
                ),
                // const SizedBox(height: 10),

                // CA Category
                const FieldLableWidget(
                  // padding: EdgeInsets.only(left: 15),
                  lable: "CA Category",
                  isRequired: true,
                ),
                // IncidentTypeMultidropdownWidget(
                //   selectedItems: GlobalState().selectedCaCategories,

                //   hintText: "CA Category",
                //   items: caCategoryDropDown,
                //   onSelect: (selectedTypes, value, isSelected) async {
                //     GlobalState().selectedCaCategories = selectedTypes;
                //     await _updateTabs(value, isSelected);
                //   },
                // ),
                // IncidentTypeFormField(
                //   selectedItems: GlobalState().selectedCaCategories,
                //   hintText: "CA Category",
                //   items: caCategoryDropDown,
                //   isRequired: true,
                //   onSelect: (selectedTypes, value, isSelected) async {
                //     GlobalState().selectedCaCategories = selectedTypes;
                //     await _updateTabs(value, isSelected);
                //   },
                // ),
                DropdownListWidget(
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  selected: selectedCaCategories,

                  isRequired: true,
                  items: caCategoryDropDown,
                  onChange: (value) async {
                    print("Selected name: ${value!.name}");

                    selectedCaCategories = value;
                    // isAddEnable();
                  },
                ),
                // const SizedBox(height: 10),

                // Assigned To
                const FieldLableWidget(
                  lable: "Assigned To",
                  isRequired: true,
                  // padding: EdgeInsets.only(left: 15),
                ),
                // If you want to use SearchDropdownWidget uncomment and fix as needed
                SearchDropdownWidget(
                  // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  controller: assignToController,
                  icon: const Icon(Icons.person),
                  isRequired: true,
                  hintText: 'Assigned To',
                  onTap: () {
                    Navigator.push<EmployeeModel>(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SearchEmployeeScreen(title: 'Assigned To'),
                      ),
                    ).then((selectedEmployee) {
                      print("${selectedEmployee?.empName} ----------------");
                      if (selectedEmployee != null) {
                        if (loginUser?.empId == selectedEmployee.empId) {
                          PopUpDialogUtility.showAlertDialogSystem(
                            context: context,
                            popupTitle: 'Warning',
                            description:
                                "Reporting Person cannot be the same as the Incident Entered By.",
                          );
                          return;
                        }
                        setReportedByDetails1(selectedEmployee);
                      }
                    });
                  },
                ),

                // const SizedBox(height: 10),

                // Notes
                TextAreaWidget(
                  isRequired: false,
                  height: 75,
                  // padding: const EdgeInsets.symmetric(horizontal: 15),
                  hintText: "Maximum charcter limit is 500",
                  controller: notesController,
                  lable: "Notes",
                  onChange: (value) {},
                ),

                // const SizedBox(height: 10),

                // Due Date
                const FieldLableWidget(
                  lable: "Due Date",
                  isRequired: true,
                  // padding: EdgeInsets.only(left: 15),
                ),
                TextFieldWidget(
                  hintText: "",
                  // padding: const EdgeInsets.symmetric(
                  //   horizontal: 15,
                  //   vertical: 5,
                  // ),
                  enabled: false,
                  controller: dueDateController,
                  onChange: (v) {},
                ),

                // const SizedBox(height: 10),

                // Status
                const FieldLableWidget(
                  // padding: EdgeInsets.only(left: 15),
                  lable: "Status",
                  isRequired: true,
                ),

                DropdownListWidget(
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  selected: selectedStatuses,

                  // (selectedStatuses != null)
                  //     ? statusDropDown[0]
                  //     : selectedStatuses,
                  isRequired: true,
                  items: statusDropDown,
                  onChange: (value) async {
                    print("Selected name: ${value!.name}");

                    selectedStatuses = value;
                    // isAddEnable();
                  },
                ),

                // const SizedBox(height: 20),
                // SizedBox(height: 20),
                // _buildFileListCard(
                //   title: "Attach Documents",
                //   files: documentFiles,
                //   isDocument: true,
                //   onUploadPressed: () => _showUploadOptions(context, true),
                // ),
                // _buildFileListCard(
                //   title: "Attach Photos",
                //   files: photoFiles,
                //   isDocument: false,
                //   onUploadPressed: () => _showUploadOptions(context, false),
                // ),
                SizedBox(height: 15),
                DocumentAndPhotoUploadWidget(
                  title: "Attach Documents",
                  isDocument: true,
                  storageKey: _docKey,
                ),

                DocumentAndPhotoUploadWidget(
                  title: "Attach Photos",
                  isDocument: false,
                  storageKey: _photoKey,
                ),

                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: FloatingButtonsBottomBar(
        cancelButtonType: ButtonType.close,
        buttonType: ButtonType.submit,
        onSave: () async {
          if (!_formKey.currentState!.validate()) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                // icon: const Icon(Icons.warning, color: Colors.orange),
                // title: const Text("Warning"),
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.warning, color: Colors.orange),
                        SizedBox(width: 5),
                        const Text("Warning"),
                        SizedBox(width: 5),
                      ],
                    ),
                    Divider(color: Colors.orange),
                  ],
                ),
                content: const Text("Please fill all mandatory details."),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      backgroundColor: Colors.blue,
                      // minimumSize: buttonSize ?? const Size(100, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
            // return; // stop further execution
          } else if (_formKey.currentState!.validate()) {
            final resultData = {
              'uniqueId': widget.uniqueId,
              'assignTo': assignToController.text,
              // 'priority': GlobalState().selectedPriorities
              //     .map((e) => e.name)
              //     .toList(),
              'priority': selectedPriorities,
              'caCategory': selectedCaCategories,
              'status': selectedStatuses,
              'dueDate': dueDateController.text,
              'caDescription': caDescriptionController.text,
              'notes': notesController.text,
            };
            // GlobalState().selectedPriorities = [];
            // GlobalState().selectedCaCategories = [];
            // GlobalState().selectedStatuses = [];
            print(" Result Data ----${resultData} ");
            print(
              "status  ${(resultData["status"] as DropdownItemModel).name}",
            );

            Navigator.of(context).pop(resultData);
          }
        },

        isSaveEnable: true,
      ),
    );
  }

  // Widget _buildFileListCard({
  //   required String title,
  //   required List<File> files,
  //   required bool isDocument,
  //   required VoidCallback onUploadPressed,
  // }) {
  //   return Card(
  //     margin: const EdgeInsets.symmetric(vertical: 12),
  //     child: Padding(
  //       padding: const EdgeInsets.all(12),
  //       child: Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 title,
  //                 style: const TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 18,
  //                 ),
  //               ),
  //               ElevatedButton.icon(
  //                 onPressed: onUploadPressed,
  //                 icon: const Icon(Icons.add, size: 18, color: Colors.white),
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: AppColors.appPrimaryColor,
  //                 ),
  //                 label: const Text(
  //                   "Upload",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 12),
  //           if (files.isEmpty)
  //             Container(
  //               padding: const EdgeInsets.all(20), // space around the icon
  //               decoration: const BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 color: Color.fromARGB(
  //                   255,
  //                   228,
  //                   224,
  //                   224,
  //                 ), // circle background color
  //               ),
  //               child: const Icon(
  //                 Icons.insert_drive_file,
  //                 size: 40, // slightly smaller so it fits nicely
  //                 color: AppColors.appPrimaryColor, // your theme color
  //               ),
  //             ),

  //           if (files.isEmpty)
  //             const Text(
  //               "No files attached",
  //               style: TextStyle(color: Colors.grey),
  //             )
  //           else
  //             ListView.builder(
  //               shrinkWrap: true,
  //               physics: const NeverScrollableScrollPhysics(),
  //               itemCount: files.length,
  //               itemBuilder: (ctx, i) {
  //                 final file = files[i];
  //                 final fileName = path.basename(file.path);

  //                 return Container(
  //                   margin: const EdgeInsets.symmetric(
  //                     vertical: 4,
  //                   ), // spacing between items
  //                   decoration: BoxDecoration(
  //                     border: Border.all(
  //                       color: Colors.grey, // border color
  //                       width: 1, // border thickness
  //                     ),
  //                     borderRadius: BorderRadius.circular(8), // rounded corners
  //                   ),
  //                   child: ListTile(
  //                     leading: isDocument
  //                         ? const Icon(
  //                             Icons.insert_drive_file,
  //                             color: AppColors.appPrimaryColor,
  //                           )
  //                         : Image.file(
  //                             file,
  //                             width: 40,
  //                             height: 40,
  //                             fit: BoxFit.cover,
  //                           ),
  //                     title: Text(fileName, overflow: TextOverflow.ellipsis),
  //                     trailing: IconButton(
  //                       icon: const Icon(
  //                         Icons.delete,
  //                         color: AppColors.appPrimaryColor,
  //                       ),
  //                       onPressed: () => _deleteFile(file, isDocument),
  //                     ),
  //                     onTap: () {
  //                       if (!isDocument) {
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                             builder: (_) =>
  //                                 ImagePreviewScreen(imageFile: file),
  //                           ),
  //                         );
  //                       }
  //                     },
  //                   ),
  //                 );
  //               },
  //             ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
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
